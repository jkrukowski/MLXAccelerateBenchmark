# MLXAccelerateBenchmark

Comparison of different approaches to implemeting part of [ApplyTimestampRules](https://github.com/openai/whisper/blob/ba3f3cd54b0e5b8ce1ab3de13e32122d0d5f98ab/whisper/decoding.py#L498-L505)

- using [MLX](https://github.com/ml-explore/mlx-swift/)
- using [MLX](https://github.com/ml-explore/mlx-swift/) with compiled version of `logSoftmax`
- using [Accelerate](https://developer.apple.com/documentation/accelerate)

## Usage

Open this package in XCode and run it to get `Google Benchmark` results or run tests for `XCTests` results.
When running from the command line I got some build problems most likely related to `MLX`.
Note that for the best results you should run both of them with `Release` configuration.

## Results

MacBook Air M1 2020, 16GB RAM

Google Benchmark results (1000 iterations)

```
name                      time           std         iterations
---------------------------------------------------------------
MLX.count=100              582937.500 ns ± 1541.19 %       1000
MLX.count=1_000            601000.000 ns ±   6.47 %        1000
MLX.count=10_000           793291.500 ns ±  93.87 %        1000
MLX.count=100_000         1223562.500 ns ±  31.89 %        1000
MLXCompiled.count=100      941062.500 ns ±   7.76 %        1000
MLXCompiled.count=1_000    906479.000 ns ±  10.71 %        1000
MLXCompiled.count=10_000  1005458.000 ns ±   7.70 %        1000
MLXCompiled.count=100_000 1291270.500 ns ±  12.27 %        1000
Accelerate.count=100         4542.000 ns ± 7343.85 %       1000
Accelerate.count=1_000       7916.000 ns ±  20.14 %        1000
Accelerate.count=10_000     31000.000 ns ±  16.61 %        1000
Accelerate.count=100_000   156709.000 ns ±  10.72 %        1000
```

XCTests results (1000 iterations)

```
MLXAccelerateBenchmarkTests.xctest
TestAccPerformance
    ◷ test100 measured (2101.761 kI ±1.457% -- CPU Instructions Retired)
    ◷ test100 measured (563.769 kC ±7.732% -- CPU Cycles)
    ◷ test100 measured (0.000 s ±10.268% -- CPU Time)
    ◷ test100 measured (0.000 s ±89.919% -- Clock Monotonic Time)
    ✔ test100 (2.116 seconds)
    ◷ test1000 measured (2109.189 kI ±0.508% -- CPU Instructions Retired)
    ◷ test1000 measured (545.364 kC ±3.632% -- CPU Cycles)
    ◷ test1000 measured (0.000 s ±5.002% -- CPU Time)
    ◷ test1000 measured (0.000 s ±12.775% -- Clock Monotonic Time)
    ✔ test1000 (0.589 seconds)
    ◷ test10000 measured (2332.336 kI ±0.757% -- CPU Instructions Retired)
    ◷ test10000 measured (577.395 kC ±4.327% -- CPU Cycles)
    ◷ test10000 measured (0.000 s ±5.893% -- CPU Time)
    ◷ test10000 measured (0.000 s ±9.033% -- Clock Monotonic Time)
    ✔ test10000 (0.652 seconds)
    ◷ test100000 measured (4725.819 kI ±0.376% -- CPU Instructions Retired)
    ◷ test100000 measured (1034.370 kC ±3.859% -- CPU Cycles)
    ◷ test100000 measured (0.000 s ±5.962% -- CPU Time)
    ◷ test100000 measured (0.000 s ±5.286% -- Clock Monotonic Time)
    ✔ test100000 (0.768 seconds)
TestMLXCompiledPerformance
    ◷ test100 measured (3573.663 kI ±0.818% -- CPU Instructions Retired)
    ◷ test100 measured (1246.022 kC ±3.808% -- CPU Cycles)
    ◷ test100 measured (0.000 s ±4.541% -- CPU Time)
    ◷ test100 measured (0.001 s ±8.351% -- Clock Monotonic Time)
    ✔ test100 (1.151 seconds)
    ◷ test1000 measured (3570.440 kI ±0.797% -- CPU Instructions Retired)
    ◷ test1000 measured (1245.645 kC ±4.877% -- CPU Cycles)
    ◷ test1000 measured (0.000 s ±5.575% -- CPU Time)
    ◷ test1000 measured (0.001 s ±8.571% -- Clock Monotonic Time)
    ✔ test1000 (1.152 seconds)
    ◷ test10000 measured (3590.643 kI ±0.829% -- CPU Instructions Retired)
    ◷ test10000 measured (1284.605 kC ±5.752% -- CPU Cycles)
    ◷ test10000 measured (0.000 s ±6.446% -- CPU Time)
    ◷ test10000 measured (0.001 s ±8.896% -- Clock Monotonic Time)
    ✔ test10000 (1.205 seconds)
    ◷ test100000 measured (3714.628 kI ±0.702% -- CPU Instructions Retired)
    ◷ test100000 measured (1463.943 kC ±31.097% -- CPU Cycles)
    ◷ test100000 measured (0.001 s ±45.859% -- CPU Time)
    ◷ test100000 measured (0.001 s ±26.221% -- Clock Monotonic Time)
    ✔ test100000 (1.886 seconds)
TestMLXPerformance
    ◷ test100 measured (3554.008 kI ±0.863% -- CPU Instructions Retired)
    ◷ test100 measured (1243.013 kC ±4.415% -- CPU Cycles)
    ◷ test100 measured (0.000 s ±5.066% -- CPU Time)
    ◷ test100 measured (0.001 s ±9.497% -- Clock Monotonic Time)
    ✔ test100 (1.153 seconds)
    ◷ test1000 measured (3548.475 kI ±0.757% -- CPU Instructions Retired)
    ◷ test1000 measured (1234.329 kC ±3.305% -- CPU Cycles)
    ◷ test1000 measured (0.000 s ±3.723% -- CPU Time)
    ◷ test1000 measured (0.001 s ±8.135% -- Clock Monotonic Time)
    ✔ test1000 (1.164 seconds)
    ◷ test10000 measured (3565.324 kI ±0.787% -- CPU Instructions Retired)
    ◷ test10000 measured (1265.140 kC ±4.046% -- CPU Cycles)
    ◷ test10000 measured (0.000 s ±6.526% -- CPU Time)
    ◷ test10000 measured (0.001 s ±6.849% -- Clock Monotonic Time)
    ✔ test10000 (1.222 seconds)
    ◷ test100000 measured (3697.270 kI ±0.627% -- CPU Instructions Retired)
    ◷ test100000 measured (1349.478 kC ±14.414% -- CPU Cycles)
    ◷ test100000 measured (0.001 s ±37.270% -- CPU Time)
    ◷ test100000 measured (0.001 s ±22.547% -- Clock Monotonic Time)
    ✔ test100000 (1.860 seconds)
Tests Passed: 0 failed, 0 skipped, 12 total (14.963 seconds)
```
