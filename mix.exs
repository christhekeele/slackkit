defmodule Slackkit.Mixfile do
  use Mix.Project

  def project, do: [
    app: :slackkit,
    version: "0.1.0",
    elixir: "~> 1.2",
    build_embedded: Mix.env == :prod,
    start_permanent: Mix.env == :prod,
    deps: deps,
  ]

  def application, do: [
    applications: [
      :logger,
      :plug,
      :cowboy,
      :websocket_client,
      :ibrowse,
      :poison,
    ],
    # mod: {Slackkit, []},
  ]

  defp deps, do: [
    { :earmark, "~> 0.2", only: :dev },
    { :ex_doc, "~> 0.11", only: :dev },
    {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.2.4"},
    plug: "~> 1.1.4",
    cowboy: "~> 1.0.4",
    websocket_client: "~> 1.1.0",
    tesla: "~> 0.2.1",
    poison: "~> 2.2.0",
    inflex: "~> 1.7.0",
  ]

end
