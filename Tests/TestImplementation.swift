import CoreML
import MLXAccelerateBenchmark
import XCTest

internal final class TestImplementation: XCTestCase {
    internal func testImplementation() {
        let logits1 = MLMultiArray.logits(count: 100)
        let accResult1 = logits1.acc_sumOfProbabilityOverTimestamps(timeTokenBegin: 10)
        let mlxResult1 = logits1.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 10)
        XCTAssertEqual(accResult1.0, mlxResult1.0, accuracy: 0.00001)
        XCTAssertEqual(accResult1.1, mlxResult1.1, accuracy: 0.00001)

        let logits2 = MLMultiArray.logits(count: 10000)
        let accResult2 = logits2.acc_sumOfProbabilityOverTimestamps(timeTokenBegin: 100)
        let mlxResult2 = logits2.mlx_sumOfProbabilityOverTimestamps(timeTokenBegin: 100)
        XCTAssertEqual(accResult2.0, mlxResult2.0, accuracy: 0.00001)
        XCTAssertEqual(accResult2.1, mlxResult2.1, accuracy: 0.00001)
    }
}
