import Accelerate
import CoreML
import MLX

public extension MLMultiArray {
    func mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: Int) -> (Float, Float) {
        let ptr = UnsafeRawBufferPointer(
            start: dataPointer,
            count: count * MemoryLayout<Float>.stride
        )
        let logits = MLXArray(ptr, shape.map { $0.intValue }, type: Float.self)
        let logProbs = log(softMax(logits))
        let timestampLogProb = logProbs[timeTokenBegin...].logSumExp()
        let maxTextTokenLogProb = logProbs[..<timeTokenBegin].max()
        return (timestampLogProb.item(), maxTextTokenLogProb.item())
    }
}

public extension MLMultiArray {
    func acc_sumOfProbabilityOverTimestamps(timeTokenBegin: Int) -> (Float, Float) {
        let timeTokenBeginOffset = linearOffset(for: [timeTokenBegin as NSNumber])

        let logprobsInputPointer = UnsafeMutableRawBufferPointer(
            start: dataPointer,
            count: count * MemoryLayout<Float>.stride
        )

        let logprobsInputDescriptor = BNNSNDArrayDescriptor(
            data: logprobsInputPointer,
            scalarType: Float.self,
            shape: .vector(count, stride: 1)
        )!

        let logprobs = BNNSNDArrayDescriptor.allocateUninitialized(
            scalarType: Float.self,
            shape: .vector(count, stride: 1)
        )
        defer { logprobs.deallocate() }

        try! BNNS.applyActivation(
            activation: BNNS.ActivationFunction.logSoftmax,
            input: logprobsInputDescriptor,
            output: logprobs,
            batchSize: 1
        )

        let timeTokenCount = count - timeTokenBeginOffset
        let noTimeTokenCount = timeTokenBeginOffset
        let logSumExpInputPointer = UnsafeMutableRawBufferPointer(
            start: logprobs.data!.advanced(by: timeTokenBeginOffset * MemoryLayout<Float>.stride),
            count: timeTokenCount * MemoryLayout<Float>.stride
        )

        let logSumExpInputDescriptor = BNNSNDArrayDescriptor(
            data: logSumExpInputPointer,
            scalarType: Float.self,
            shape: .vector(timeTokenCount, stride: 1)
        )!

        let timestampLogProb = BNNSNDArrayDescriptor.allocateUninitialized(
            scalarType: Float.self,
            shape: .vector(1, stride: 1)
        )
        defer { timestampLogProb.deallocate() }

        try! BNNS.applyReduction(
            .logSumExp,
            input: logSumExpInputDescriptor,
            output: timestampLogProb,
            weights: nil
        )

        let maxTextTokenLogProbInputPointer = UnsafeMutableRawBufferPointer(
            start: logprobs.data,
            count: noTimeTokenCount * MemoryLayout<Float>.stride
        )

        let maxTextTokenLogProbInputDescriptor = BNNSNDArrayDescriptor(
            data: maxTextTokenLogProbInputPointer,
            scalarType: Float.self,
            shape: .vector(noTimeTokenCount, stride: 1)
        )!

        let maxTextTokenLogProb = BNNSNDArrayDescriptor.allocateUninitialized(
            scalarType: Float.self,
            shape: .vector(1, stride: 1)
        )
        defer { maxTextTokenLogProb.deallocate() }

        try! BNNS.applyReduction(
            .max,
            input: maxTextTokenLogProbInputDescriptor,
            output: maxTextTokenLogProb,
            weights: nil
        )

        let timestampLogProbValue = timestampLogProb.makeArray(of: Float.self)![0]
        let maxTextTokenLogProbValue = maxTextTokenLogProb.makeArray(of: Float.self)![0]
        return (timestampLogProbValue, maxTextTokenLogProbValue)
    }
}
