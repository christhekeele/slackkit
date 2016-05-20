Slackkit
========

> *The comprehensive toolbelt for working with Slack in Elixir.*

Installation
------------

1. Add `slackkit` to your list of dependencies in `mix.exs`:

```elixir
def deps do
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

- `Slackkit.Bot` for building Bot Users
- `Slackkit.Hook` for building Outgoing Webhooks
- `Slackkit.Command` for building custom Slash Commands
- `Slackkit.Application` for building complete Slack Applications

This provides all you need for full-stack Slack Application development. You can compose commands that cause bots to send messages, and webhooks that update your bot's state.

Under the hood, the plumbing that works with the Slack APIs are:

- `Slackkit.Web` for leveraging Slack's Web API and Incoming Webhooks
- `Slackkit.RTM` for leveraging Slack's Real Time Messaging API
- `Slackkit.Auth` for navigating Slack's authentication protocols

These tools are useful for when you want to something really custom, but their use is generally abstracted through the porcelain tools.

### Porcelain

#### Slackkit.Bot

Slackkit models the Bot Users you program as composed of various GenEvent handlers. For each Bot User you register, you can attach many different Slackkit Bot handlers. Creating a bot is simple:

```elixir
defmodule MySlackApp.EchoBot do
  use Slackkit.Bot

  use GenEvent

  # def handle_event({event, rtm_client}, state)

  def handle_event({%{type: "message", subtype: "channel_join", channel: channel}, client}, state) do
    Slackkit.RTM.Client.Actions.type_message client, channel, "Hey there! I'm going to repeat everything you say."
    {:ok, state}
  end

  def handle_event({%{type: "message", text: message, user: user, channel: channel}, client = %{myself: myself}}, state)
  when user != myself do
    Slackkit.RTM.Client.Actions.type_message client, channel, message
    {:ok, [ state | message ]}
  end

  # Catchall
  def handle_event(_, state) do
    {:ok, state}
  end
end
```

Notice that we had to add `GenEvent` ourselves. This is because there's an easier way to build bots that plays the role of `GenEvent` for us:

```elixir
defmodule MySlackApp.EchoBot do
  use Slackkit.Bot
  use Slackkit.Bot.DSL

  # def handle_xxx(event, client, state)

  def handle_joined_channel(%{channel: channel}, client, state) do
    type_message client, channel, "Hey there! I'm going to repeat everything you say."
    {:ok, state}
  end

  def handle_message(%{text: message, user: user, channel: channel}, client = %{myself: myself}, state)
  when user != myself do
    type_message client, channel, message
    {:ok, [ state | message ]}
  end
end
```

The Bot DSL sets up useful aliases and imports, normalizes Slack event names, adds tons of RTM targeted event handler callback functions for you, defines an all-purpose `handle_unknown` handler method, provides default callbacks, and still lets you override all the other non-`handle_event` `GenEvent` callbacks. To see the available event callbacks check out the `Slackkit.RTM.Event` docs or run `Slackkit.RTM.Event.callbacks` for a quick reference.

#### Slackkit.Application

Make any OTP application a Slack application by using `Slack.Application` instead of `Application`. This allows you to register your Slackkit components and have a complete supervision tree built out that will bring the whole thing up in one breath:

```elixir
defmodule MySlackApp do
  use Slackkit.Application

  # Tells Slackkit to mount EchoBot to the bot user called :foo_bar_bot in our
  # config. You can associate multiple Slackkit Bots per Slack Bot User and vice-versa.
  use MySlackApp.EchoBot, :foo_bar_bot

  # In the pipeline!
  # # Tells Slackkit to mount EchoCommand to the command called :foo_bar_command in our
  # # config. You can associate multiple Slackkit Commands per Slack Slash Command
  # # and vice-versa.
  # use MySlackApp.EchoCommand, :foo_bar_command

  # In the pipeline!
  # # Tells Slackkit to mount EchoHook to the command called :foo_bar_hook in our
  # # config. You can associate multiple Slackkit Hooks per Slack Outgoing Webhook
  # # and vice-versa.
  # use MySlackApp.EchoHook, :foo_bar_hook

end
```

Then, add to your app's config.exs:

```elixir
use Mix.Config

# Name the tokens Slack gives us as entities within our application.
config :slackkit, users: [
  foo_bar_bot: "token",
]
# In the pipeline!
# config :slackkit, commands: [
#   foo_bar_command: "token"
# ]
# config :slackkit, hooks: [
#   foo_bar_hook: "token"
# ]

# Configure settings for each component.

config :slackkit, MySlackApp.EchoBot, [
  # Makes EchoBot's initial state be `:state` instead of `[]`.
  initial: :state,
]

# In the pipeline!
# config :slackkit, MySlackApp.EchoCommand, [
#   # Makes EchoCommand's initial state be `:state` instead of `[]`.
#   initial: :state,
#   # Registers Command under this path instead of the default `"commands"`.
#   path: "commands/foo_bar"
# ]
# config :slackkit, MySlackApp.EchoHook, [
#   # Makes EchoHook's initial state be `:state` instead of `[]`.
#   initial: :state,
#   # Registers Hook under this path instead of the default `"hooks"`.
#   path: "hooks/foo_bar"
# ]
```

Finally, add your application module to your `mix.exs`:

```elixir
def application do
  [applications: [:slackkit],
  mod: {MySlackApp, []}]
end
```

When you run `iex -S mix` it will bring up everything you've registered in your application, supervised appropriately, websockets open, plugs mounted, the works.

### Plumbing

#### Slackkit.RTM
