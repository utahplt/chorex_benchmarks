defmodule AutogenBenchmarks do
def run_bench100000x1() do
  Chorex.start(Bench100000x1.Chorex, %{Bench100000x1Alice => Bench100000x1AliceImpl, Bench100000x1Bob => Bench100000x1BobImpl}, [])
end
def run_bench10000x10() do
  Chorex.start(Bench10000x10.Chorex, %{Bench10000x10Alice => Bench10000x10AliceImpl, Bench10000x10Bob => Bench10000x10BobImpl}, [])
end
def run_bench1000x100() do
  Chorex.start(Bench1000x100.Chorex, %{Bench1000x100Alice => Bench1000x100AliceImpl, Bench1000x100Bob => Bench1000x100BobImpl}, [])
end
def run_bench100x1000() do
  Chorex.start(Bench100x1000.Chorex, %{Bench100x1000Alice => Bench100x1000AliceImpl, Bench100x1000Bob => Bench100x1000BobImpl}, [])
end
def run_bench10x10000() do
  Chorex.start(Bench10x10000.Chorex, %{Bench10x10000Alice => Bench10x10000AliceImpl, Bench10x10000Bob => Bench10x10000BobImpl}, [])
end
def run_bench1x100000() do
  Chorex.start(Bench1x100000.Chorex, %{Bench1x100000Alice => Bench1x100000AliceImpl, Bench1x100000Bob => Bench1x100000BobImpl}, [])
end

end
