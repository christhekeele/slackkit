defmodule Slackkit.Bot.Supervisor do
  use Supervisor
  
  import Supervisor.Spec
  
  def start_link(name, token, handlers) do
    Supervisor.start_link __MODULE__, {name, token, handlers}
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
    Enum.map( handlers, fn handler ->
      initial = Application.get_env(:slackkit, handler) |> Keyword.get(:initial, [])
      worker Slackkit.Bot.Event.Monitor, [manager_for(name), handler, initial]
    end )
  end
  
  defp module_for(name) do
    name |> Atom.to_string |> Macro.camelize
  end
  
  defp manager_for(name) do
    name |> module_for |> Module.concat(Event.Manager)
  end
  
end