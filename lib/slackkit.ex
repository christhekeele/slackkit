defmodule Slackkit do
  use Application
  
  import Supervisor.Spec
  
  def start(_type, _args) do
    Supervisor.start_link(specs, strategy: :one_for_one, name: Slackkit.Supervisor)
  end
  
  defp specs, do: [
    # supervisor(Aha.Slack.Endpoint, []),
    # supervisor(Aha.Slack.Bots, []),
  ]
  
end
