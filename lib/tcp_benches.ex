defmodule TcpBenches do
  import Chorex

  ###############################################
  # Application choreography and implementation #
  ###############################################

  defmodule HandlerChor do
    import Chorex

    defchor [Handler, TcpClient] do
      def run(TcpClient.(sock)) do
        loop(Handler.(%{byte_count: 0}), TcpClient.(sock))
      end

      def loop(Handler.(state), TcpClient.(sock)) do
        TcpClient.read(sock) ~> Handler.(msg)

        with Handler.({resp, new_state}) <- Handler.run(msg, state) do
          if Handler.continue?(resp, new_state) do
            Handler.fmt_reply(resp) ~> TcpClient.(resp)
            TcpClient.send_over_socket(sock, resp)
            loop(Handler.(new_state), TcpClient.(sock))
          else
            Handler.fmt_reply(resp) ~> TcpClient.(resp)
            TcpClient.send_over_socket(sock, resp)
            TcpClient.shutdown(sock)
            Handler.ack_shutdown()
          end
        end
      end
    end
  end

  defmodule HandlerImpl do
    use HandlerChor.Chorex, :handler

    @impl true
    def run({:error, _reason}, state) do
      # IO.inspect(reason, label: "[handler] error reason")
      {{:halt, ""}, state}
    end

    def run({:ok, "stop\n"}, state) do
      {{:halt, "Thank you for your time. Goodbye now!\n"}, state}
    end

    def run({:ok, msg}, state) do
      # IO.inspect(msg, label: "[handler] msg")
      len = String.length(msg)
      c = Map.get(state, :byte_count, 0)

      {{:continue, "thank you for your message; #{len} bytes, #{len + c} total\n"},
       %{byte_count: c + len}}
    end

    @impl true
    def continue?({:continue, _resp}, _state), do: true
    def continue?({:halt, _resp}, _state), do: false
    def continue?(:closed, _state), do: false

    @impl true
    def fmt_reply({_status, resp}), do: resp

    @impl true
    def ack_shutdown() do
      # IO.inspect("down", label: "[handler] shutting down")
      nil
    end
  end

  defmodule ClientImpl do
    use HandlerChor.Chorex, :tcpclient

    @impl true
    def read(sock) do
      # 0 = all available bytes
      :gen_tcp.recv(sock, 0)
    end

    @impl true
    def send_over_socket(sock, msg) do
      # IO.inspect(msg, label: "[client] msg")
      :gen_tcp.send(sock, msg)
    end

    @impl true
    def shutdown(sock) do
      :gen_tcp.close(sock)
    end
  end


  #########################################################
  # Listener and accepter choreography and implementation #
  #########################################################

  defmodule ListenerChor do
    defchor [Listener, AccepterPool] do
      def run(Listener.(config)) do
        Listener.get_listener_socket(config) ~> AccepterPool.({:ok, socket})
        loop(AccepterPool.(socket))
      end

      def loop(AccepterPool.(listen_socket)) do
        AccepterPool.accept_and_handle_connection(listen_socket)
        # loop(AccepterPool.(listen_socket))
      end
    end
  end

  defmodule ListenerImpl do
    use ListenerChor.Chorex, :listener

    @hardcoded_options [mode: :binary, active: false]

    @impl true
    def get_listener_socket(config) do
      default_options = [
        backlog: 1024,
        nodelay: true,
        send_timeout: 30_000,
        send_timeout_close: true,
        reuseaddr: true
      ]

      opts =
        Enum.uniq_by(
          @hardcoded_options ++ config[:user_options] ++ default_options,
          fn
            {key, _} when is_atom(key) -> key
            key when is_atom(key) -> key
          end
        )

      # Expected to return {:ok, :inet.socket()}
      :gen_tcp.listen(config[:port], opts)
      # |> IO.inspect(label: "listener socket")
    end
  end

  defmodule AccepterPoolImpl do
    use ListenerChor.Chorex, :accepterpool

    @impl true
    def accept_and_handle_connection(listen_socket) do
      # IO.inspect(listen_socket, label: "[accepter_pool] socket")

      {:ok, socket} = :gen_tcp.accept(listen_socket)

      # startup instance of the handler choreography
      Chorex.start(
        HandlerChor.Chorex,
        %{Handler => HandlerImpl, TcpClient => ClientImpl},
        [socket]
      )
    end
  end

  #####################################
  # Connector module for the TCP test #
  #####################################

  defmodule ConnBot do
    def simple_talk(port_no) do
      # Fire up the choreography
      Chorex.start(
        ListenerChor.Chorex,
        %{Listener => ListenerImpl, AccepterPool => AccepterPoolImpl},
        [%{port: port_no, user_options: []}]
      )

      # Alright, let's try talking to ourselves
      {:ok, socket} = :gen_tcp.connect(String.to_charlist("localhost"), port_no, [], 500)

      :gen_tcp.send(socket, "open mailbox\n")

      receive do
	    {:tcp, ^socket, msg} ->
		  msg
      end

      :gen_tcp.send(socket, "read leaflet\n")
      receive do
	    {:tcp, ^socket, msg} ->
		  msg
      end

      :gen_tcp.send(socket, "stop\n")
      receive do
        {:tcp, ^socket, ~c"Thank you for your time. Goodbye now!\n"} ->
          :ok
        {:tcp, ^socket, msg} ->
          dbg({:err, msg})
      end
    end
  end
end
