defmodule Slackkit.Bot.Supervisor do
  use Supervisor

  import Supervisor.Spec

  def start_link(name, handlers) do
    start_link name, token_for(name), handlers
  end
  def start_link(name, token, handler) when not is_list handler do
    start_link name, token,  handler |> List.wrap |> List.flatten
  end
  def start_link(name, token, handlers) do
    Supervisor.start_link __MODULE__, {name, token, handlers_with_state(name, handlers)}
  end

  defp token_for(name) do
    case Application.get_env(:slackkit, :users, []) |> Keyword.fetch(name) do
      {:ok, token} -> token
    end
  end

  defp handlers_with_state(name, handlers) do
    handlers |> Enum.map( fn
      handler ->
        {handler, Application.get_env(:slackkit, handler, []) |> Keyword.get(name, [])}
      {handler, initial} ->
        {handler, initial}
    end )
  end

  def init({name, token, handlers}) do
    specs(name, token, handlers) |> supervise(strategy: :one_for_one, id: name)
  end

  defp specs(name, token, handlers), do: [
    event_manager(name),
    rtm(name, token),
  ] ++ event_monitors(name, handlers)

  defp event_manager(name) do
    worker GenEvent, [[name: manager_for(name)]]
  end

  defp rtm(name, token) do
    worker Slackkit.RTM, [token, manager_for(name)], id: name
  end

  defp event_monitors(name, handlers) do
    handlers |> Enum.map( fn {handler, initial} ->
      worker Slackkit.Bot.Event.Monitor, [manager_for(name), handler, initial], id: id_for(name, handler)
    end )
  end

  defp module_for(name) do
    name |> Atom.to_string |> Macro.camelize
  end

  defp id_for(name, handler) do
    name |> module_for |> Module.concat(handler)
  end

  defp manager_for(name) do
    id_for name, Event.Manager
  end

end
