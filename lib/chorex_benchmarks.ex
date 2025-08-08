defmodule ChorexBenchmarks do
  @time 10
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

  # def big_chor_stats do
  #   Benchee.run(
  #     %{
  #       "lots of actors, no try" => fn -> BigRunner.run(1, false) end,
  #       "lots of actors, with try" => fn -> BigRunner.run(1, true) end
  #     },
  #     time: @time,
  #     memory_time: @memory_time
  #   )
  #   :ok
  # end

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

  def miniblock_stats do
    # :logger.add_primary_filter(:dbg_filter, {&LogFilter.filter/2, []})
    Logger.configure(level: :alert) # suppress crash messages
    # Logger.configure(level: :none) # suppress crash messages
    Benchee.run(
      %{
        "miniblock: with try block" => fn -> LoopBenches.block_runner_try() end,
        "miniblock: without try block" => fn -> LoopBenches.block_runner_no_try() end,
        "miniblock: using rescue" => fn -> LoopBenches.block_runner_try_and_rescue() end,
      },
      time: @time,
      memory_time: @memory_time
    )
    Logger.configure(level: :warning) # restore
    :ok
  end

  def flat_loop_stats do
    Logger.configure(level: :alert) # suppress crash messages
    [
      Benchee.run(
        %{
          "flat loop with try, 1000 iterations" => fn -> LoopBenches.flat_runner(1000, true) end,
          "flat loop without try, 1000 iterations" => fn -> LoopBenches.flat_runner(1000, false) end,
          "loop: crashy, 1000 iterations" => fn -> LoopBenches.crashy_runner(1000) end,
        },
        time: @time,
        memory_time: @memory_time
      ),

      Benchee.run(
        %{
          "flat loop with try, 10000 iterations" => fn -> LoopBenches.flat_runner(10000, true) end,
          "flat loop without try, 10000 iterations" => fn -> LoopBenches.flat_runner(10000, false) end,
          "loop: crashy, 10000 iterations" => fn -> LoopBenches.crashy_runner(10000) end,
        },
        time: @time,
        memory_time: @memory_time
      ),
    ]
    Logger.configure(level: :warning) # restore
    :ok
  end

  def new_nested_stats do
    Logger.configure(level: :alert) # suppress crash messages
    Benchee.run(
      %{
        "nested, no  try,   100" => fn -> LoopBenches.crashy_nested_runner(100, false, false) end,
        "nested, no  crash, 100" => fn -> LoopBenches.crashy_nested_runner(100, false, true) end,
        "nested, yes crash, 100" => fn -> LoopBenches.crashy_nested_runner(100, true, true) end,
      },
      time: @time,
      memory_time: @memory_time
    )
    Benchee.run(
      %{
        "nested, no  try,   1000" => fn -> LoopBenches.crashy_nested_runner(1000, false, false) end,
        "nested, no  crash, 1000" => fn -> LoopBenches.crashy_nested_runner(1000, false) end,
        "nested, yes crash, 1000" => fn -> LoopBenches.crashy_nested_runner(1000, true) end,
      },
      time: @time,
      memory_time: @memory_time
    )
    Benchee.run(
      %{
        "nested, no  try,   10000" => fn -> LoopBenches.crashy_nested_runner(10000, false, false) end,
        "nested, no  crash, 10000" => fn -> LoopBenches.crashy_nested_runner(10000, false) end,
        "nested, yes crash, 10000" => fn -> LoopBenches.crashy_nested_runner(10000, true) end,
      },
      time: @time,
      memory_time: @memory_time
    )
    Logger.configure(level: :warning) # restore
    :ok
  end

  def nested_loop_stats do
    Logger.configure(level: :alert) # suppress crash messages
    [
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
    ]
    Logger.configure(level: :warning) # restore
    :ok
  end

  def stats do
    [
      miniblock_stats(),
      flat_loop_stats(),
      nested_loop_stats(),
      sm_stats(),
      # big_chor_stats()
    ]
    :ok
  end
end
