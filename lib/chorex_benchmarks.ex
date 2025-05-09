defmodule ChorexBenchmarks do
  @time 20
  @memory_time 0

  def smol_stats do
    Benchee.run(
      %{
        "state machine no try" => fn -> TbagBenches.go(:good, false) end,
        "state machine with try" => fn -> TbagBenches.go(:good, true) end,
        "state machine with try & recovery" => fn -> TbagBenches.go(:bad, true) end
      },
      time: @time,
      memory_time: @memory_time
    )
    :ok
  end

  # state-machine stats
  def sm_stats do
    Logger.configure(level: :none) # suppress crash messages
    Benchee.run(
      %{
        "state machine no try" => fn -> TbagBenches.go(:good, false) end,
        "state machine with try" => fn -> TbagBenches.go(:good, true) end,
        "state machine with try & recovery" => fn -> TbagBenches.go(:bad, true) end
      },
      time: @time,
      memory_time: @memory_time
    )
    Logger.configure(level: :warning) # restore
    :ok
  end

  def stats do
    [
      Benchee.run(
        %{
          "miniblock: with try block" => fn -> LoopBenches.block_runner_try() end,
          "miniblock: without try block" => fn -> LoopBenches.block_runner_no_try() end,
        },
        time: @time,
        memory_time: @memory_time
      ),

      Benchee.run(
        %{
          "flat loop with try, 1000 iterations" => fn -> LoopBenches.flat_runner(1000, true) end,
          "flat loop without try, 1000 iterations" => fn -> LoopBenches.flat_runner(1000, false) end,
        },
        time: @time,
        memory_time: @memory_time
      ),

      Benchee.run(
        %{
          "flat loop with try, 10000 iterations" => fn -> LoopBenches.flat_runner(10000, true) end,
          "flat loop without try, 10000 iterations" => fn -> LoopBenches.flat_runner(10000, false) end,
        },
        time: @time,
        memory_time: @memory_time
      ),

      Benchee.run(
        %{
          "loop: with try, 100 iterations, split work" => fn -> LoopBenches.runner(100, true, true) end,
          "loop: with try, 100 iterations, no split work" => fn -> LoopBenches.runner(100, true, false) end,
          "loop: no try, 100 iterations, split work" => fn -> LoopBenches.runner(100, false, true) end,
          "loop: no try, 100 iterations, no split work" => fn -> LoopBenches.runner(100, false, false) end,
        },
        time: @time,
        memory_time: @memory_time
      ),

      Benchee.run(
        %{
          "loop: with try, 1000 iterations, split work" => fn -> LoopBenches.runner(1000, true, true) end,
          "loop: with try, 1000 iterations, no split work" => fn -> LoopBenches.runner(1000, true, false) end,
          "loop: no try, 1000 iterations, split work" => fn -> LoopBenches.runner(1000, false, true) end,
          "loop: no try, 1000 iterations, no split work" => fn -> LoopBenches.runner(1000, false, false) end,
        },
        time: @time,
        memory_time: @memory_time
      ),

      Benchee.run(
        %{
          "loop: with try, 10000 iterations, split work" => fn -> LoopBenches.runner(10000, true, true) end,
          "loop: with try, 10000 iterations, no split work" => fn -> LoopBenches.runner(10000, true, false) end,
          "loop: no try, 10000 iterations, split work" => fn -> LoopBenches.runner(10000, false, true) end,
          "loop: no try, 10000 iterations, no split work" => fn -> LoopBenches.runner(10000, false, false) end,
        },
        time: @time,
        memory_time: @memory_time
      ),

      sm_stats()
    ]
    :ok
  end
end
