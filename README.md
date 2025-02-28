# ChorexBenchmarks

You will need a recent version of Elixir (1.18 or better is best) and at least Perl 5.36 to use this.

Running the benchmarks:

 1. Clone this repo.
 2. Get the dependencies (Chorex and Benchee) with `mix deps.get`.
 3. Run `perl bench_maker.pl`. This generates files inside `lib/autogen_benchmarks/` and some helper scripts in `lib/autogen_benchmarks.ex`. You shouldn't need to interact with these directly.
 4. Fire up `iex -S mix`. It will take a long time to compile. (~3–5 minutes on a modern machine with plenty of RAM.)
 5. Run the benchmarks with `ChorexBenchmarks.stats()`. This takes about 3 minutes.
