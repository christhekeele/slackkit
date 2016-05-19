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
    applications: [:logger, :httpoison, :exjsx, :websocket_client],
    # mod: {Slackkit, []},
  ]

  defp deps, do: [
    # slack: "~> 0.5.0",
    # plug: "~> 1.0",
    # cowboy: "~> 1.0.0",
    # websocket_client: "~> 1.1.0",
    { :earmark, "~> 0.2.0", only: :dev }, 
    { :ex_doc, "~> 0.11", only: :dev }, 
    # { :websocket_client, "~> 0.6.1", git: "https://github.com/jeremyong/websocket_client" },
    # slack: "~> 0.5.0",
    plug: "~> 1.1.4",
    cowboy: "~> 1.0.4",
    websocket_client: "~> 1.1.0",
    httpoison: "~> 0.8.3",
    exjsx: "~> 3.2.0"
  ]
  
end
