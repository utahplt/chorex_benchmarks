defmodule LoopBenches do
  import Chorex

  defmodule PlainLoop do
    defchor [Runner, Monitor] do
      def run(Monitor.(laps), Monitor.(do_try?), Runner.(split_work?)) do
        if Monitor.(do_try?) do
          loop_try(Monitor.(laps), Runner.(0), Runner.(split_work?))
        else
          loop_no_try(Monitor.(laps), Runner.(0), Runner.(split_work?))
        end
      end

      def loop_try(Monitor.(laps), Runner.(lap_no), Runner.(split_work?)) do
        if Runner.(split_work?) do
          try do
            Runner.(lap_no) ~> Monitor.(l)
            if Monitor.(l >= laps) do
              Monitor.(:done)
              Runner.(:finished)
            else
              loop_try(Monitor.(laps), Runner.(lap_no + 1), Runner.(split_work?))
              Monitor.work_hard()
            end
          rescue
            loop_try(Monitor.(laps), Runner.(lap_no + 1), Runner.(split_work?))
          end
          Runner.work_hard()
        else
          try do
            Runner.(lap_no) ~> Monitor.(l)
            if Monitor.(l >= laps) do
              Monitor.(:done)
              Runner.(:finished)
            else
              loop_try(Monitor.(laps), Runner.(lap_no + 1), Runner.(split_work?))
              Monitor.work_hard()
              Runner.work_hard()
            end
          rescue
            loop_try(Monitor.(laps), Runner.(lap_no + 1), Runner.(split_work?))
          end
        end
      end

      def loop_no_try(Monitor.(laps), Runner.(lap_no), Runner.(split_work?)) do
        Runner.(lap_no) ~> Monitor.(l)
        if Monitor.(l >= laps) do
          Monitor.(:done)
          Runner.(:finished)
        else
          loop_no_try(Monitor.(laps), Runner.(lap_no + 1), Runner.(split_work?))
          Monitor.work_hard()
          Runner.work_hard()
        end
      end
    end
  end

  defmodule FlatLoop do
    defchor [FlatRunner, FlatMonitor] do
      def run(FlatMonitor.(laps), FlatMonitor.(do_try?)) do
        if FlatMonitor.(do_try?) do
          loop_try(FlatMonitor.(laps), FlatRunner.(0))
        else
          loop_no_try(FlatMonitor.(laps), FlatRunner.(0))
        end
      end

      def loop_try(FlatMonitor.(laps), FlatRunner.(n)) do
        FlatRunner.(n) ~> FlatMonitor.(l)
        if FlatMonitor.(l <= laps) do
          try do
            FlatMonitor.work_hard()
            FlatRunner.work_hard()
          rescue
            FlatMonitor.work_hard()
            FlatRunner.work_hard()
          end
          loop_try(FlatMonitor.(laps), FlatRunner.(n + 1))
        else
          FlatMonitor.(:done)
          FlatRunner.(:finished)
        end
      end

      def loop_no_try(FlatMonitor.(laps), FlatRunner.(n)) do
        FlatRunner.(n) ~> FlatMonitor.(l)
        if FlatMonitor.(l <= laps) do
          FlatMonitor.work_hard()
          FlatRunner.work_hard()
          loop_no_try(FlatMonitor.(laps), FlatRunner.(n + 1))
        else
          FlatMonitor.(:done)
          FlatRunner.(:finished)
        end
      end
    end
  end

  defmodule MyFlatRunner do
    use FlatLoop.Chorex, :flatrunner

    @impl true
    def work_hard() do
      # IO.puts(".")
      for i <- 0..1000 do
        :crypto.hash(:sha256, "foo#{i}")
      end
      # |> length()
    end
  end

  defmodule MyFlatMonitor do
    use FlatLoop.Chorex, :flatmonitor

    @impl true
    def work_hard() do
      for i <- 0..1000 do
        :crypto.hash(:sha256, "foo#{i}")
      end
      # |> length()
    end
  end

  defmodule MyRunner do
    use PlainLoop.Chorex, :runner

    @impl true
    def work_hard() do
      for i <- 0..1000 do
        :crypto.hash(:sha256, "foo#{i}")
      end
      |> length()
    end
  end

  defmodule MyMonitor do
    use PlainLoop.Chorex, :monitor

    @impl true
    def work_hard() do
      for i <- 0..1000 do
        :crypto.hash(:sha256, "foo#{i}")
      end
      |> length()
    end
  end

  def flat_runner(laps \\ 100, use_try? \\ true) do
    Chorex.start(FlatLoop.Chorex, %{FlatRunner => MyFlatRunner, FlatMonitor => MyFlatMonitor}, [laps, use_try?])

    m1 = receive do
	  {:chorex_return, _, _} = m ->
		m
    end

    m2 = receive do
	  {:chorex_return, _, _} = m ->
		m
    end

    {m1, m2}
  end

  def runner(laps \\ 100, use_try? \\ true, split_work? \\ true) do
    Chorex.start(PlainLoop.Chorex, %{Runner => MyRunner, Monitor => MyMonitor}, [laps, use_try?, split_work?])

    m1 =
      receive do
        {:chorex_return, _, _} = m -> m
      end

    # dbg(:got1)

    m2 =
      receive do
        {:chorex_return, _, _} = m -> m
      end

    # dbg(:got2)

    {m1, m2}
  end


  # defmodule MiniBlock do
  #   defchor [Searcher, Verifier] do
  #     def run(Verifier.(data), Verifier.(do_try?)) do
  #       with Verifier.(start_nonce) <- Verifier.start_nonce() do
  #         Verifier.({data, start_nonce}) ~> Searcher.({data, start_nonce})
  #         if Verifier.(do_try?) do
  #           with Verifier.({nonce, hash}) <- search(Verifier.({data, start_nonce}), Searcher.({data, start_nonce}), Searcher.(0)) do
  #             Verifier.({nonce, hash})
  #             Searcher.(:good_job)
  #           end
  #         else
  #           with Verifier.({nonce, hash}) <- search_no_try(Verifier.({data, start_nonce}), Searcher.({data, start_nonce}), Searcher.(0)) do
  #             Verifier.({nonce, hash})
  #             Searcher.(:good_job)
  #           end
  #         end
  #       end
  #     end

  #     def search_no_try(Verifier.({data, n}), Searcher.({data, n}), Searcher.(x)) do
  #       Searcher.log(data, n, x)
  #       Verifier.log(data, n)
  #       with Searcher.(hash) <- Searcher.hash(data, n + x) do
  #         Searcher.(hash) ~> Verifier.(hash)
  #         if Verifier.good_hash?(hash) do
  #           Searcher.(n + x) ~> Verifier.(final_nonce)
  #           Verifier.({final_nonce, hash})
  #         else
  #           search_no_try(Verifier.({data, n}), Searcher.({data, n}), Searcher.(x + 1))
  #         end
  #       end
  #     end

  #     def search(Verifier.({data, n}), Searcher.({data, n}), Searcher.(x)) do
  #       # Searcher.(IO.write(:stderr, "x: " <> to_string(x) <> "\n"))
  #       try do
  #         with Searcher.(hash) <- Searcher.hash(data, n + x) do
  #           Searcher.({hash, x}) ~> Verifier.({hash, x})
  #           if Verifier.good_hash?({hash, x}) do
  #             # Searcher.(IO.write(:stderr, "DONE" <> to_string(n + x) <> "\n"))
  #             # Verifier.(IO.write(:stderr, "DONE\n"))
  #             Searcher.(n + x) ~> Verifier.(final_nonce)
  #             Verifier.({final_nonce, hash})
  #           else
  #             search(Verifier.({data, n}), Searcher.({data, n}), Searcher.(x + 1))
  #           end
  #         end
  #       rescue
  #         search(Verifier.({data, n}), Searcher.({data, n}), Searcher.(x + 1))
  #       end
  #     end
  #   end
  # end

  # defmodule MySearcher do
  #   use MiniBlock.Chorex, :searcher
  #   require Logger

  #   @impl true
  #   def hash(data, nonce) do
  #     h = :crypto.hash(:sha256, data <> <<nonce>>)
  #     if 200 < nonce && nonce < 250 do
  #       Logger.error("hash: (#{inspect binary_slice(h, 0, 1)}) #{inspect(h)}")
  #       # IO.puts(:stderr, "hash: (#{inspect binary_slice(h, 0, 1)}) #{inspect(h)}")
  #     end
  #     if nonce > 280 do
  #       send(self(), :dbg_state)
  #       :init.stop()            # emergency break
  #     end
  #     h
  #   end

  #   @impl true
  #   def log(_data, _n, _x) do
  #     # dbg({:searcher, n, x})
  #   end
  # end

  # defmodule MyVerifier do
  #   use MiniBlock.Chorex, :verifier

  #   @impl true
  #   def log(_data, _n) do
  #     # dbg({:verifier, n})
  #   end

  #   @impl true
  #   def good_hash?({a, _}), do: good_hash?(a)

  #   def good_hash?(bin) do
  #     <<0>> == binary_slice(bin, 0, 1)
  #   end

  #   @impl true
  #   def start_nonce() do
  #     42
  #   end
  # end

  # defmodule VolitileVerifier do
  #   use MiniBlock.Chorex, :verifier

  #   @impl true
  #   def log(_data, _n) do
  #     # dbg({:verifier, n})
  #   end

  #   @impl true
  #   def good_hash?({bin, x}) do
  #     if <<0>> == binary_slice(bin, 0, 1) do
  #       # IO.write(:stderr, "good #{x}\n")
  #       true
  #     else
  #       IO.write(:stderr, "bad #{x} #{inspect binary_slice(bin, 0, 1)} #{inspect self()}\n")
  #       raise "Kaboom!"
  #     end
  #   end

  #   def good_hash?(bin) do
  #     if <<0>> == binary_slice(bin, 0, 1) do
  #       IO.write(:stderr, "good ")
  #       true
  #     else
  #       IO.write(:stderr, "bad #{inspect binary_slice(bin, 0, 1)}")
  #       raise "Kaboom!"
  #     end
  #   end

  #   @impl true
  #   def start_nonce() do
  #     42
  #   end
  # end


  # def block_runner_try(data \\ "hello") do
  #   Chorex.start(MiniBlock.Chorex, %{Searcher => MySearcher, Verifier => MyVerifier}, [data, true])

  #   receive do
  #     {:chorex_return, _, _} = m -> m
  #   end
  #   receive do
  #     {:chorex_return, _, _} = m -> m
  #   end
  # end

  # def block_runner_no_try(data \\ "hello") do
  #   # IO.write(:stderr, ",")
  #   Chorex.start(MiniBlock.Chorex, %{Searcher => MySearcher, Verifier => MyVerifier}, [data, false])
  #   # IO.write(:stderr, ".")

  #   receive do
  #     {:chorex_return, _, _} = m ->
  #       # IO.write(:stderr, ":")
  #       m
  #   end
  #   receive do
  #     {:chorex_return, _, _} = m ->
  #       # IO.write(:stderr, ";")
  #       m
  #   end
  # end

  # def block_runner_try_and_rescue(data \\ "hello") do
  #   # IO.write(:stderr, ",")
  #   Chorex.start(MiniBlock.Chorex, %{Searcher => MySearcher, Verifier => VolitileVerifier}, [data, true])
  #   # IO.write(:stderr, ".")

  #   # Getting strange hangs with this
  #   receive do
  #     {:chorex_return, _, _} = m ->
  #       # IO.write(:stderr, ":")
  #       m
  #   end
  #   receive do
  #     {:chorex_return, _, _} = m ->
  #       # IO.write(:stderr, ";")
  #       m
  #   end
  # end
end
