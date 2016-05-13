Slackkit
========

> *The comprehensive toolbelt for working with Slack in Elixir.*

Installation
------------

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add slackkit to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:slackkit, "~> 0.0.1"}]
end
```

2. Ensure slackkit is started before your application:

```elixir
def application do
  [applications: [:slackkit]]
end
```

Usage
-----

Slackkit has two layers: plumbing and porcelain.

You can use the porcelain to quickly get started on your own Slack integrations:

- `Slackkit.Bot` for building Bot users
- `Slackkit.Hook` for building Incoming Webhooks
- `Slackkit.Command` for building custom Slash Commands
- `Slackkit.App` for building custom complete Slack Applications

Under the hood, the plumbing that works with the Slack APIs are:

- `Slackkit.Web` for leveraging Slack's Web API
- `Slackkit.RTM` for leveraging Slack's Real Time Messaging API
- `Slackkit.Auth` for navigating Slack's authentication protocols