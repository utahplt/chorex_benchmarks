defmodule BadBatch do
  import Chorex

  defmodule MiniBlock do
    defchor [Searcher, Verifier] do
      def run(Verifier.(data), Verifier.(do_try?)) do
        with Verifier.(start_nonce) <- Verifier.start_nonce() do
          Verifier.({data, start_nonce}) ~> Searcher.({data, start_nonce})
          with Verifier.({nonce, hash}) <- search(Verifier.({data, start_nonce}), Searcher.({data, start_nonce}), Searcher.(0)) do
            Verifier.({nonce, hash})
            Searcher.(:good_job)
          end
        end
      end

      def search(Verifier.({data, n}), Searcher.({data, n}), Searcher.(x)) do
        try do
          with Searcher.(hash) <- Searcher.hash(data, n + x) do
            Searcher.({hash, x}) ~> Verifier.({hash, x})
            if Verifier.good_hash?({hash, x}) do
              Searcher.(n + x) ~> Verifier.(final_nonce)
              Verifier.({final_nonce, hash})
            else
              search(Verifier.({data, n}), Searcher.({data, n}), Searcher.(x + 1))
            end
          end
        rescue
          search(Verifier.({data, n}), Searcher.({data, n}), Searcher.(x + 1))
        end
      end
    end
  end

  defmodule MySearcher do
	use MiniBlock.Chorex, :searcher
    require Logger

    @impl true
    def hash(data, nonce) do
	  h = :crypto.hash(:sha256, data <> <<nonce>>)
      if 200 < nonce && nonce < 250 do
        # Logger.error("hash: (#{inspect binary_slice(h, 0, 1)}) #{inspect(h)}")
        # IO.write(:stderr, "hash: (#{inspect binary_slice(h, 0, 1)}) #{inspect(h)}")
      end
      if nonce > 280 do
        send(self(), :dbg_state)
        :init.stop()            # emergency break
      end
      h
    end
  end

  defmodule VolitileVerifier do
    use MiniBlock.Chorex, :verifier
    require Logger

    @impl true
    def good_hash?({bin, x}) do
	  if <<0>> == binary_slice(bin, 0, 1) do
        # IO.write(:stderr, "good #{x}\n")
        true
      else
        # Logger.error("bad #{x} #{inspect binary_slice(bin, 0, 1)} #{inspect self()}\n")
        IO.write(:stderr, "bad #{x} #{inspect binary_slice(bin, 0, 1)}\n")
        raise "Kaboom!"
	  end
    end

    def good_hash?(bin) do
	  if <<0>> == binary_slice(bin, 0, 1) do
        IO.write(:stderr, "good ")
        true
      else
        IO.write(:stderr, "bad #{inspect binary_slice(bin, 0, 1)}")
        raise "Kaboom!"
	  end
    end

    @impl true
    def start_nonce() do
	  42
    end
  end

  def block_runner_try_and_rescue(data \\ "hello") do
    Chorex.start(MiniBlock.Chorex, %{Searcher => MySearcher, Verifier => VolitileVerifier}, [data, true])

    receive do
	  {:chorex_return, _, _} = m ->
        m
    end
    receive do
	  {:chorex_return, _, _} = m ->
        m
    end
  end

end
