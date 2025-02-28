defmodule AutogenBenchmarks do
def run_bench100x1() do
  Chorex.start(Bench100x1.Chorex, %{Bench100x1Alice => Bench100x1AliceImpl, Bench100x1Bob => Bench100x1BobImpl}, [])
end
def run_bench10x10() do
  Chorex.start(Bench10x10.Chorex, %{Bench10x10Alice => Bench10x10AliceImpl, Bench10x10Bob => Bench10x10BobImpl}, [])
end
def run_bench1x100() do
  Chorex.start(Bench1x100.Chorex, %{Bench1x100Alice => Bench1x100AliceImpl, Bench1x100Bob => Bench1x100BobImpl}, [])
end
def run_bench1x10() do
  Chorex.start(Bench1x10.Chorex, %{Bench1x10Alice => Bench1x10AliceImpl, Bench1x10Bob => Bench1x10BobImpl}, [])
end
def run_bench10x1() do
  Chorex.start(Bench10x1.Chorex, %{Bench10x1Alice => Bench10x1AliceImpl, Bench10x1Bob => Bench10x1BobImpl}, [])
end

end
