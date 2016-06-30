Slackkit
========

> *The comprehensive toolbelt for working with Slack in Elixir.*

Installation
------------

1. Add `slackkit` to your list of dependencies in `mix.exs`:

```elixir
defp deps do
  [slackkit: "~> 0.1"]
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

Slackkit has two layers: porcelain and plumbing.

You can use the porcelain to quickly get started on your own Slack integrations:

These should be links to tutorials.

- `Slackkit.Bot` for building Bot Users
- `Slackkit.Hook` for building Outgoing Webhooks
- `Slackkit.Command` for building custom Slash Commands
- `Slackkit.Actions` for triggering high-level Slack events
- `Slackkit.Application` for building complete Slack Applications

This provides all you need for full-stack Slack Application development. You can compose commands that cause bots to send messages, and webhooks that update your bot's state, all integrated without registering an actual 'application' with Slack.

Under the hood, the plumbing that works with the Slack APIs are:

- `Slackkit.Web` for leveraging Slack's Web API and Incoming Webhooks
- `Slackkit.RTM` for leveraging Slack's Real Time Messaging API
- `Slackkit.Auth` for navigating Slack's authentication protocols

These tools are useful for when you want to build something really custom, but their use is generally abstracted through the porcelain tools.
