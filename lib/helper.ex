defmodule Helper do
  def conc_atom(a1, a2) do
    s1 = a1 |> Atom.to_string() |> String.replace_prefix("Elixir.", "")
    s2 = a2 |> Atom.to_string() |> String.replace_prefix("Elixir.", "")
    String.to_atom(s1 <> s2)
  end

  def downcase_atom(atom) do
    atom
    |> Atom.to_string()
    |> String.downcase()
    |> String.replace_prefix("elixir.", "")
    |> String.to_atom()
  end

  def fresh_atom(prefix) do
    String.to_atom(prefix <> to_string(abs(:erlang.monotonic_time())))
  end

  @doc """
  Build a choreography in `module_name` consisting of two actors that
  send messages back and forth.

  There should be `try_blocks` of try blocks, with each block having
  `block_size` communications in them.

  Builds a module for the choreography as well as implementations for
  the two actors. Creates a function `runner_name` that fires the
  whole thing off.
  """
  defmacro build_chor(module_name, runner_name, try_blocks, block_size) do
    {:__aliases__, am, [mod_atom]} = module_name
    actor1_atom = conc_atom(mod_atom, Alice)
    actor2_atom = conc_atom(mod_atom, Bar)

    actor1_impl_atom = conc_atom(actor1_atom, Impl)
    actor2_impl_atom = conc_atom(actor2_atom, Impl)

    actor1_downcase = downcase_atom(actor1_atom)
    actor2_downcase = downcase_atom(actor2_atom)

    actor1 = {:__aliases__, am, [actor1_atom]}
    actor2 = {:__aliases__, am, [actor2_atom]}
    actor1_impl = {:__aliases__, am, [actor1_impl_atom]}
    actor2_impl = {:__aliases__, am, [actor2_impl_atom]}

    blocks =
      for block_idx <- 1..try_blocks do
        comms =
          for comm_idx <- 1..block_size do
            _comm_id = "#{block_idx}_#{comm_idx}"

            quote do
              unquote(actor1).(1) ~> unquote(actor2).(_)
              unquote(actor2).(1) ~> unquote(actor1).(_)
            end
          end

        quote do
          try do
            unquote_splicing(comms)
          rescue
            unquote(actor1).(42)
            unquote(actor2).(42)
          end
        end
      end

    quote do
      defmodule unquote(module_name) do
        import Chorex

        defchor [unquote(actor1), unquote(actor2)] do
          def run() do
            (unquote_splicing(blocks))
          end
        end
      end

      defmodule unquote(actor1_impl) do
        use unquote(module_name).Chorex, unquote(actor1_downcase)
      end

      defmodule unquote(actor2_impl) do
        use unquote(module_name).Chorex, unquote(actor2_downcase)
      end

      def unquote(runner_name) do
        Chorex.start(
          unquote(module_name).Chorex,
          %{unquote(actor1) => unquote(actor1_impl), unquote(actor2) => unquote(actor2_impl)},
          []
        )
      end
    end
  end
end
