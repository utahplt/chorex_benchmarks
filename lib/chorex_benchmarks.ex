defmodule ChorexBenchmarks do
  @time 20
  @memory_time 0

  # state-machine stats
  def sm_stats do
    Logger.configure(level: :none) # suppress crash messages
    Benchee.run(
      %{
        "state machine (baseline)" => fn -> TbagBenches.go(:good, false) end,
        "state machine (chk)" => fn -> TbagBenches.go(:good, true) end,
        "state machine (chk+rescue)" => fn -> TbagBenches.go(:bad, true) end
      },
      time: @time,
      memory_time: @memory_time,
      formatters: [{Benchee.Formatters.Console, extended_statistics: true}]

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
        "miniblock (baseline)" => fn -> LoopBenches.block_runner_no_try() end,
        "miniblock (chk)" => fn -> LoopBenches.block_runner_try() end,
        "miniblock (chk+rescue)" => fn -> LoopBenches.block_runner_try_and_rescue() end,
      },
      time: @time,
      memory_time: @memory_time,
      formatters: [{Benchee.Formatters.Console, extended_statistics: true}]

    )
    Logger.configure(level: :warning) # restore
    :ok
  end

  def flat_loop_stats do
    Logger.configure(level: :alert) # suppress crash messages
    Benchee.run(
      %{
        "flat loop 10k iters (baseline)" => fn -> LoopBenches.flat_runner(10000, false) end,
        "flat loop 10k iters (chk)" => fn -> LoopBenches.flat_runner(10000, true) end,
        "flat loop 10k iters (chk+rescue)" => fn -> LoopBenches.crashy_runner(10000) end,
      },
      time: @time,
      memory_time: @memory_time,
      formatters: [{Benchee.Formatters.Console, extended_statistics: true}]

    )
    Logger.configure(level: :warning) # restore
    :ok
  end

  def nested_loop_stats do
    Logger.configure(level: :alert) # suppress crash messages
    # Benchee.run(
    #   %{
    #     "nested loop 100 iters (baseline)" => fn -> LoopBenches.crashy_nested_runner(100, false, false) end,
    #     "nested loop 100 iters (chk)" => fn -> LoopBenches.crashy_nested_runner(100, false, true) end,
    #     "nested loop 100 iters (chk+rescue)" => fn -> LoopBenches.crashy_nested_runner(100, true, true) end,
    #   },
    #   time: @time,
    #   memory_time: @memory_time,
    #   formatters: [{Benchee.Formatters.Console, extended_statistics: true}]
    # )
    Benchee.run(
      %{
        "nested loop 1k iters (baseline)" => fn -> LoopBenches.crashy_nested_runner(1000, false, false) end,
        "nested loop 1k iters (chk)" => fn -> LoopBenches.crashy_nested_runner(1000, false) end,
        "nested loop 1k iters (chk+rescue)" => fn -> LoopBenches.crashy_nested_runner(1000, true) end,
      },
      time: @time,
      memory_time: @memory_time,
      formatters: [{Benchee.Formatters.Console, extended_statistics: true}]
    )
    Benchee.run(
      %{
        "nested loop 10k iters (baseline)" => fn -> LoopBenches.crashy_nested_runner(10000, false, false) end,
        "nested loop 10k iters (chk)" => fn -> LoopBenches.crashy_nested_runner(10000, false) end,
        "nested loop 10k iters (chk+rescue)" => fn -> LoopBenches.crashy_nested_runner(10000, true) end,
      },
      time: @time,
      memory_time: @memory_time,
      formatters: [{Benchee.Formatters.Console, extended_statistics: true}]
    )
    Logger.configure(level: :warning) # restore
    :ok
  end

  def stats(_do_heavy? \\ false) do
    [
      sm_stats(),
      miniblock_stats(),
      flat_loop_stats(),
      nested_loop_stats()
    ]
    :ok
  end
end
