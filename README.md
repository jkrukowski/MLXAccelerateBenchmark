# MLXAccelerateBenchmark

Comparison of different approaches to implemeting part of [ApplyTimestampRules](https://github.com/openai/whisper/blob/ba3f3cd54b0e5b8ce1ab3de13e32122d0d5f98ab/whisper/decoding.py#L498-L505)

- using [MLX](https://github.com/ml-explore/mlx-swift/)
- using [Accelerate](https://developer.apple.com/documentation/accelerate)

## Usage

Open this package in XCode and run it to get `Google Benchmark` results or run tests for `XCTests` results.
When running from the command line I got some build problems most likely related to `MLX`.
Note that for the best results you should run both of them with `Release` configuration.

## Results

MacBook Air M1 2020, 16GB RAM

Google Benchmark results (1000 iterations)

```
name                     time           std         iterations
--------------------------------------------------------------
MLX.count=100             587145.500 ns ± 262.35 %        1000
MLX.count=1_000           594812.500 ns ±  21.53 %        1000
MLX.count=10_000          641666.500 ns ±  20.22 %        1000
MLX.count=100_000        1083354.500 ns ±  34.75 %        1000
Accelerate.count=100        5792.000 ns ± 3709.85 %       1000
Accelerate.count=1_000      5209.000 ns ±  57.79 %        1000
Accelerate.count=10_000    22417.000 ns ±  76.18 %        1000
Accelerate.count=100_000  157312.500 ns ±  12.22 %        1000
```

XCTests results (1000 iterations)

```
MLXAccelerateBenchmarkTests.xctest
TestAccPerformance
    ◷ test100 measured (2099.075 kI ±0.806% -- CPU Instructions Retired)
    ◷ test100 measured (550.345 kC ±4.274% -- CPU Cycles)
    ◷ test100 measured (0.000 s ±5.253% -- CPU Time)
    ◷ test100 measured (0.000 s ±30.370% -- Clock Monotonic Time)
    ✔ test100 (1.609 seconds)
    ◷ test1000 measured (2111.818 kI ±0.594% -- CPU Instructions Retired)
    ◷ test1000 measured (555.816 kC ±4.951% -- CPU Cycles)
    ◷ test1000 measured (0.000 s ±6.099% -- CPU Time)
    ◷ test1000 measured (0.000 s ±25.928% -- Clock Monotonic Time)
    ✔ test1000 (0.593 seconds)
    ◷ test10000 measured (2339.736 kI ±0.793% -- CPU Instructions Retired)
    ◷ test10000 measured (580.415 kC ±4.061% -- CPU Cycles)
    ◷ test10000 measured (0.000 s ±4.763% -- CPU Time)
    ◷ test10000 measured (0.000 s ±24.035% -- Clock Monotonic Time)
    ✔ test10000 (0.604 seconds)
    ◷ test100000 measured (4732.365 kI ±0.354% -- CPU Instructions Retired)
    ◷ test100000 measured (1021.915 kC ±1.836% -- CPU Cycles)
    ◷ test100000 measured (0.000 s ±2.103% -- CPU Time)
    ◷ test100000 measured (0.000 s ±1.774% -- Clock Monotonic Time)
    ✔ test100000 (0.756 seconds)
TestMLXPerformance
    ◷ test100 measured (3554.236 kI ±0.726% -- CPU Instructions Retired)
    ◷ test100 measured (1264.372 kC ±4.045% -- CPU Cycles)
    ◷ test100 measured (0.000 s ±4.859% -- CPU Time)
    ◷ test100 measured (0.001 s ±13.272% -- Clock Monotonic Time)
    ✔ test100 (1.178 seconds)
    ◷ test1000 measured (3558.945 kI ±0.627% -- CPU Instructions Retired)
    ◷ test1000 measured (1273.967 kC ±5.704% -- CPU Cycles)
    ◷ test1000 measured (0.000 s ±6.685% -- CPU Time)
    ◷ test1000 measured (0.001 s ±12.222% -- Clock Monotonic Time)
    ✔ test1000 (1.191 seconds)
    ◷ test10000 measured (3571.264 kI ±0.503% -- CPU Instructions Retired)
    ◷ test10000 measured (1265.419 kC ±4.320% -- CPU Cycles)
    ◷ test10000 measured (0.000 s ±6.301% -- CPU Time)
    ◷ test10000 measured (0.001 s ±16.808% -- Clock Monotonic Time)
    ✔ test10000 (1.276 seconds)
    ◷ test100000 measured (3700.911 kI ±0.723% -- CPU Instructions Retired)
    ◷ test100000 measured (1318.873 kC ±5.424% -- CPU Cycles)
    ◷ test100000 measured (0.001 s ±24.051% -- CPU Time)
    ◷ test100000 measured (0.001 s ±19.103% -- Clock Monotonic Time)
    ✔ test100000 (1.756 seconds)
Tests Passed: 0 failed, 0 skipped, 8 total (9.026 seconds)
```
