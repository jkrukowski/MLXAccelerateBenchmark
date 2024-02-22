import CoreML
import MLXAccelerateBenchmark
import XCTest

internal final class TestMLXPerformance: XCTestCase {
    internal func test100() {
        let logits1 = MLMultiArray.logits(count: 100)
        measure(metrics: Self.metrics, options: Self.options) {
            _ = logits1.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 10)
        }
    }

    internal func test1000() {
        let logits2 = MLMultiArray.logits(count: 1000)
        measure(metrics: Self.metrics, options: Self.options) {
            _ = logits2.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 100)
        }
    }

    internal func test10000() {
        let logits3 = MLMultiArray.logits(count: 10000)
        measure(metrics: Self.metrics, options: Self.options) {
            _ = logits3.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 1000)
        }
    }

    internal func test100000() {
        let logits4 = MLMultiArray.logits(count: 100_000)
        measure(metrics: Self.metrics, options: Self.options) {
            _ = logits4.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 10000)
        }
    }
}
