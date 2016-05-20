defmodule Slackkit.Bot.DSL do

  use GenEvent

  defmacro __using__(_) do
    quote location: :keep, unquote: false do

      import Slackkit.RTM.Client.Lookup

      def init(state),                    do: Slackkit.Bot.DSL.init(state)
      # def handle_event(event, state),     do: Slackkit.Bot.DSL.handle_event(event, state)
      def handle_call(message, state),    do: Slackkit.Bot.DSL.handle_call(message, state)
      def handle_info(message, state),    do: Slackkit.Bot.DSL.handle_info(message, state)
      def terminate(reason, state),       do: Slackkit.Bot.DSL.terminate(reason, state)
      def code_change(old, state, extra), do: Slackkit.Bot.DSL.code_change(old, state, extra)

      defoverridable [
        init: 1,
        # handle_event: 2,
        handle_call: 2,
        handle_info: 2,
        terminate: 2,
        code_change: 3,
      ]

      Slackkit.RTM.Event.events |> Enum.map( fn event ->
        func_name = String.to_atom("handle_" <> Atom.to_string(event))
        def handle_event({event = %{tag: unquote(event)}, client}, state) do
          unquote(func_name)(event, client, state)
        end
      end )

      def handle_event(event, state) do
        IO.puts "\nGot unhandled event: #{inspect event}\n"
        {:ok, state}
      end

      Slackkit.RTM.Event.events |> Enum.map( fn event ->
        func_name = String.to_atom("handle_" <> Atom.to_string(event))
        def unquote(func_name)(_event, _client, state) do
          IO.puts "handled event in #{unquote(func_name)}"
          { :ok, state }
        end
        defoverridable [{func_name, 3}]
      end )

    end
  end

end
