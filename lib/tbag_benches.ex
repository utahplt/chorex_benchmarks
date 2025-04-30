defmodule TbagBenches do
  import Chorex

  defmodule TbagServer do
    defchor [Gateway, Worker, Player] do
      def run(Player.(conf), Gateway.(use_try?)) do
        Player.get_name() ~> Gateway.(player_name)
        Gateway.(player_name) ~> Worker.(player_name)

        if Gateway.(use_try?) do
          play_game(@move_safe/2, Player.(conf), Worker.(player_name), Worker.(:atrium))
        else
          play_game(@move_unsafe/2, Player.(conf), Worker.(player_name), Worker.(:atrium))
        end
      end

      def play_game(movement, Player.(conf), Worker.(player_name), Worker.(game_state)) do
        with Worker.({new_state, new_conf}) <- movement.(Worker.(game_state), Player.(conf)) do
          if Worker.game_over?(new_state) do
            Worker.("Thank you for playing " <> to_string(player_name)) ~> Player.(m)
            Player.report(m, conf)
          else
            Worker.(new_conf) ~> Player.(new_conf)
            play_game(movement, Player.(new_conf), Worker.(player_name), Worker.(new_state))
          end
        end
      end

      def move_safe(Worker.(game_state), Player.(conf)) do
        try do
          move_unsafe(Worker.(game_state), Player.(conf))
        rescue
          Worker.inform_failure() ~> Player.(feedback)
          Player.report(feedback, conf) ~> Worker.(new_conf)
          Worker.({game_state, new_conf})
        end
      end

      def move_unsafe(Worker.(game_state), Player.(conf)) do
        Worker.prompt(game_state) ~> Player.(prompt)
        Player.make_move(prompt, conf) ~> Worker.(move)
        with Worker.(new_state) <- Worker.realize_move(move, game_state) do
          Worker.inform(new_state) ~> Player.(feedback)
          Player.report(feedback, conf) ~> Worker.(new_player_conf)
          Worker.({new_state, new_player_conf})
        end
      end

    end
  end

  defmodule GatewayImpl do
    use TbagServer.Chorex, :gateway
  end

  defmodule WorkerImpl do
    use TbagServer.Chorex, :worker

    @impl true
    def game_over?(:end), do: true
    def game_over?(_), do: false

    # :atrium -> :open_mbox -> :haz_leaflet -> :read_leaflet
    @impl true
    def prompt(:atrium),
        do: "You are standing in an open field west of a white house with a boarded front door. There is a small mailbox here."
    def prompt(:open_mbox),
        do: "Opening the mailbox reveals a small leaflet."
    def prompt(:haz_leaflet),
        do: "Leaflet: (taken)"
    def prompt(:read_leaflet),
        do: "The leaflet says, 'Welcome to this homage to Zork!'"

    @impl true
    def inform(st), do: st

    @impl true
    def realize_move(:open, :atrium), do: :open_mbox
    def realize_move(:take, :open_mbox), do: :haz_leaflet
    def realize_move(:read, :haz_leaflet), do: :read_leaflet
    def realize_move(_, :read_leaflet), do: :end
    # blows up if not in the sequence!

    @impl true
    def inform_failure() do
      IO.puts("I'm sorry, that's not something I can do.")
      "I'm sorry, that's not something I can do."
    end
  end

  defmodule PlayerImpl do
    use TbagServer.Chorex, :player

    @impl true
    def get_name(), do: "cretin"

    @impl true
    def make_move("You are standing in an open field" <> _, _conf),
        do: :open
    def make_move("Opening the mailbox reveals a small leaflet" <> _, :good),
        do: :take
    def make_move("Opening the mailbox reveals a small leaflet" <> _, :bad),
        do: :read
    def make_move("Leaflet: (taken)" <> _, _conf),
        do: :read
    def make_move("The leaflet says" <> _, _conf),
        do: :jump

    @impl true
    # flip back
    def report("I'm sorry, that's not something I can do.", _st) do
      IO.puts("oops, made mistake")
      :good
    end
    def report(msg, st) do
      IO.puts("Feedback: #{msg}")
      st
    end
  end

  def go(conf \\ :good, recovery? \\ true) do
    Chorex.start(TbagServer.Chorex,
                 %{Gateway => GatewayImpl,
                 Player => PlayerImpl,
                 Worker => WorkerImpl}, [conf, recovery?])
  end
end
