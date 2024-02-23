import Benchmark
import CoreML
import MLXAccelerateBenchmark

let settings: BenchmarkSetting = Iterations(1000)

internal let mlx = BenchmarkSuite(name: "MLX", settings: settings) { suite in
    let logits1 = MLMultiArray.logits(count: 100)
    suite.benchmark("count=100") {
        _ = logits1.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 10)
    }

    let logits2 = MLMultiArray.logits(count: 1000)
    suite.benchmark("count=1_000") {
        _ = logits2.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 100)
    }

    let logits3 = MLMultiArray.logits(count: 10000)
    suite.benchmark("count=10_000") {
        _ = logits3.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 1000)
    }

    let logits4 = MLMultiArray.logits(count: 100_000)
    suite.benchmark("count=100_000") {
        _ = logits4.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 10000)
    }
}

internal let mlxCompiled = BenchmarkSuite(name: "MLXCompiled", settings: settings) { suite in
    let logits1 = MLMultiArray.logits(count: 100)
    suite.benchmark("count=100") {
        _ = logits1.mlx_sumOfProbabilityOverTimestampsCompiled(timeTokenBegin: 10)
    }

    let logits2 = MLMultiArray.logits(count: 1000)
    suite.benchmark("count=1_000") {
        _ = logits2.mlx_sumOfProbabilityOverTimestampsCompiled(timeTokenBegin: 100)
    }

    let logits3 = MLMultiArray.logits(count: 10000)
    suite.benchmark("count=10_000") {
        _ = logits3.mlx_sumOfProbabilityOverTimestampsCompiled(timeTokenBegin: 1000)
    }

    let logits4 = MLMultiArray.logits(count: 100_000)
    suite.benchmark("count=100_000") {
        _ = logits4.mlx_sumOfProbabilityOverTimestampsCompiled(timeTokenBegin: 10000)
    }
}

internal let accelerate = BenchmarkSuite(name: "Accelerate", settings: settings) { suite in
    let logits1 = MLMultiArray.logits(count: 100)
    suite.benchmark("count=100") {
        _ = logits1.acc_sumOfProbabilityOverTimestamps(timeTokenBegin: 10)
    }

    let logits2 = MLMultiArray.logits(count: 1000)
    suite.benchmark("count=1_000") {
        _ = logits2.acc_sumOfProbabilityOverTimestamps(timeTokenBegin: 100)
    }

    let logits3 = MLMultiArray.logits(count: 10000)
    suite.benchmark("count=10_000") {
        _ = logits3.acc_sumOfProbabilityOverTimestamps(timeTokenBegin: 1000)
    }

    let logits4 = MLMultiArray.logits(count: 100_000)
    suite.benchmark("count=100_000") {
        _ = logits4.acc_sumOfProbabilityOverTimestamps(timeTokenBegin: 10000)
    }
}

public let allBenchmarks = [
    mlx,
    mlxCompiled,
    accelerate,
]
