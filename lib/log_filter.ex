defmodule LogFilter do
  def filter(log_event, _opts) do
    case log_event do
      %{msg: m} when is_binary(m) ->
        if m =~ "chorex-dbg", do: :log, else: :stop
      _ ->
        :stop
    end
  end
end

