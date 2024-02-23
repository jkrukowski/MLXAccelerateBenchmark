import CoreML

public extension [Float] {
    static func random(_ count: Int) -> [Element] {
        (0 ..< count).map { _ in
            Float.random(in: -10 ... 10)
        }
    }
}

public extension MLMultiArray {
    /// Calculate the linear offset by summing the products of each dimension’s
    /// index with the dimension’s stride
    ///
    /// More info here: https://developer.apple.com/documentation/coreml/mlmultiarray/2879231-subscript
    @inline(__always)
    internal func linearOffset(for index: [NSNumber], strides strideInts: [Int]? = nil) -> Int {
        var linearOffset = 0
        let strideInts = strideInts ?? strides.map(\.intValue)
        for (dimension, stride) in zip(index, strideInts) {
            linearOffset += dimension.intValue * stride
        }
        return linearOffset
    }

    /// Create `MLMultiArray` of shape [1, 1, arr.count] and fill up the last
    /// dimension with with values from arr.
    static func logits(count: Int) -> MLMultiArray {
        let arr = Array<Float>.random(count)
        let logits = try! MLMultiArray(shape: [arr.count] as [NSNumber], dataType: .float)
        let strides = logits.strides.map(\.intValue)
        let ptr = UnsafeMutablePointer<Float>(OpaquePointer(logits.dataPointer))
        for (index, value) in arr.enumerated() {
            let linearOffset = logits.linearOffset(for: [index as NSNumber], strides: strides)
            ptr[linearOffset] = value
        }
        return logits
    }
}
