defmodule ChorexBenchmarks do
  def stats do
    Benchee.run(
      %{
        "1x100" => fn -> AutogenBenchmarks.run_bench1x100() end,
        "10x10" => fn -> AutogenBenchmarks.run_bench10x10() end,
        "100x1" => fn -> AutogenBenchmarks.run_bench100x1() end,
        "10x1" => fn -> AutogenBenchmarks.run_bench10x1() end,
        "1x10" => fn -> AutogenBenchmarks.run_bench1x10() end
      },
      time: 30
      # memory_time: 10,
      # reduction_time: 10
    )
  end
end
