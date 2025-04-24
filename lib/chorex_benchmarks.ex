defmodule ChorexBenchmarks do
  def stats do
    [
      Benchee.run(
        %{
          "miniblock: with try block" => fn -> LoopBenches.block_runner_try() end,
          "miniblock: without try block" => fn -> LoopBenches.block_runner_no_try() end,
        },
        time: 30
      ),

      Benchee.run(
        %{
          "loop: with try, 100 iterations, split work" => fn -> LoopBenches.runner(100, true, true) end,
          "loop: with try, 100 iterations, no split work" => fn -> LoopBenches.runner(100, true, false) end,
          "loop: no try, 100 iterations, split work" => fn -> LoopBenches.runner(100, false, true) end,
          "loop: no try, 100 iterations, no split work" => fn -> LoopBenches.runner(100, false, false) end,
        },
        time: 30
      ),

      Benchee.run(
        %{
          "loop: with try, 1000 iterations, split work" => fn -> LoopBenches.runner(1000, true, true) end,
          "loop: with try, 1000 iterations, no split work" => fn -> LoopBenches.runner(1000, true, false) end,
          "loop: no try, 1000 iterations, split work" => fn -> LoopBenches.runner(1000, false, true) end,
          "loop: no try, 1000 iterations, no split work" => fn -> LoopBenches.runner(1000, false, false) end,
        },
        time: 30
      ),

        # "loop: with try, 10000 iterations, split work" => fn -> LoopBenches.runner(10000, true, true) end,
        # "loop: with try, 10000 iterations, no split work" => fn -> LoopBenches.runner(10000, true, false) end,
        # "loop: no try, 10000 iterations, split work" => fn -> LoopBenches.runner(10000, false, true) end,
        # "loop: no try, 10000 iterations, no split work" => fn -> LoopBenches.runner(10000, false, false) end,
    ]
  end
end
