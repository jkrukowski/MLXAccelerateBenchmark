// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MLXAccelerateBenchmark",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(name: "benchmark", targets: ["MLXAccelerateBenchmarkCLI"]),
        .library(name: "MLXAccelerateBenchmark", targets: ["MLXAccelerateBenchmark"]),
    ],
    dependencies: [
        .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0"),
        .package(url: "https://github.com/ml-explore/mlx-swift", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "MLXAccelerateBenchmarkCLI",
            dependencies: [
                "MLXAccelerateBenchmarkSuite",
                .product(name: "Benchmark", package: "swift-benchmark"),
            ]
        ),
        .target(
            name: "MLXAccelerateBenchmarkSuite",
            dependencies: [
                "MLXAccelerateBenchmark",
                .product(name: "Benchmark", package: "swift-benchmark"),
            ]
        ),
        .target(
            name: "MLXAccelerateBenchmark",
            dependencies: [
                .product(name: "MLX", package: "mlx-swift"),
            ]
        ),
        .testTarget(
            name: "MLXAccelerateBenchmarkTests",
            dependencies: ["MLXAccelerateBenchmark"]
        ),
    ]
)
