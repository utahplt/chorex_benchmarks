# ChorexBenchmarks

Running the benchmarks:

 1. Clone this repo.
 2. Run `perl bench_maker.pl`. This generates files inside `lib/autogen_benchmarks/` and some helper scripts in `lib/autogen_benchmarks.ex`. You shouldn't need to interact with these directly.
 3. Fire up `iex -S mix`. It will take a long time to compile. (~3–5 minutes on a modern machine with plenty of RAM.)
 4. Run the benchmarks with `ChorexBenchmarks.stats()`. This takes about 3 minutes.
