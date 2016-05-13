defmodule Slackkit.Mixfile do
  use Mix.Project

  def project, do: [
    app: :slackkit,
    version: "0.0.1",
    elixir: "~> 1.2",
    build_embedded: Mix.env == :prod,
    start_permanent: Mix.env == :prod,
    deps: deps,
  ]

  def application, do: [
    applications: [:logger],
    mod: {Slackkit, []},
  ]

  defp deps, do: [
    plug: "~> 1.0",
    cowboy: "~> 1.0.0",
    websocket_client: "~> 1.1.0",
  ]
  
end
