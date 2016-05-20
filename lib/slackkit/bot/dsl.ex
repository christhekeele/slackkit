defmodule Slackkit.Bot.DSL do

  use GenEvent

  defmacro __using__(_) do
    quote location: :keep, unquote: false do

      import Slackkit.RTM.Client.Lookups
      import Slackkit.RTM.Client.Actions

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

      Slackkit.RTM.Event.event_callbacks |> Enum.map( fn { event, callback } ->
        def handle_event({event = %{tag: unquote(event)}, client}, state) do
          unquote(callback)(event, client, state)
        end
      end )

      def handle_event(event, state) do
        {:ok, state}
      end

      Slackkit.RTM.Event.callbacks |> Enum.map( fn callback ->
        def unquote(callback)(_event, _client, state) do
          { :ok, state }
        end
        defoverridable [{callback, 3}]
      end )

    end
  end

end
