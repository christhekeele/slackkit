Adding a Bot to an Application
==============================

This guide will go over how to add bots to a Slackkit Application. It will continue where [building a bot]() left off, so we have a bot out of the box to build an application around.

Centralize your configuration
-----------------------------

We can move a lot of configuration out of parameters and into the `config.exs`. For example, given our previous command:

```elixir
Slackkit.Bot.Supervisor.start_link(:boten_anna, "SLACK_TOKEN", [{MySlackApp.Bots.EchoBot, %{greeting: "Hello! I'm going to repeat everything you say!"}, {MySlackApp.Bots.SpyBot, %{report_to: "@YOUR_USERNAME"}}])
```

We can centralize all of this by adding to our config:

```elixir
use Mix.Config

config :slackkit, MySlackApp.Bots.EchoBot, [
  boten_anna: %{
    greeting: "Hey there! I'm going to repeat everything you say."
  }
]

config :slackkit, MySlackApp.Bots.SpyBot, [
  boten_anna: %{
    report_to: "@YOUR_USERNAME"
  }
]
```

Now our configuration will be autodiscovered when we run the command:

```elixir
Slackkit.Bot.Supervisor.start_link(:boten_anna, "SLACK_TOKEN", [MySlackApp.Bots.EchoBot, MySlackApp.Bots.SpyBot])
```

Name your tokens
----------------

Next, we can move our token itself into the `config.exs`, which is probably where it ought to have lived all along.

Add to your config:

```elixir
config :slackkit, users: [
  boten_anna: "SLACK_TOKEN"
]
```

Now our command can just be:

```elixir
Slackkit.Bot.Supervisor.start_link(:boten_anna, [MySlackApp.Bots.EchoBot, MySlackApp.Bots.SpyBot])
```

Start your bots at boot
-----------------------

Since we've pulled out the configuration into our config file, we can convert our project into a Slackkit Application.

First, add an extra behaviour into your bots:

```elixir
defmodule MySlackApp.Bots.EchoBot do
  use Slackkit.Bot

end
```

```elixir
defmodule MySlackApp.Bots.SpyBot do
  use Slackkit.Bot

end
```

This line makes your Bots discoverable when used inside Applications. So let's make our project one. Go to `lib/my_slack_app.ex` and add:

```elixir
defmodule MySlackApp do
  use Slackkit.Application

  use MySlackApp.Bots.EchoBot, :boten_anna
  use MySlackApp.Bots.SpyBot, :boten_anna
end
```

This makes our Application start with a supervisor that will boot our Bot.Supervisors for us. Now all we don't have to touch any application code if we want to reconfigure our application to use a different token or initial configuration, we just have to touch our `config.exs`.

Start your application at boot
------------------------------

Now all we have to do to set everything in motion at app launch is add the traditional `mod` instruction to our `mix.exs` (if it wasn't there already):

```elixir
def application do
  [applications: [:logger, :slackkit],
   mod: {MySlackApp, []}]
end
```
