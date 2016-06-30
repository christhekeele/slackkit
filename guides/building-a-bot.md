Building a Bot
==============

This is an introductory tool to building a Slack bot with slackkit.

Setup
-----

1. Generate a new starter project:

```sh
$ mix new my_slack_app
```

2. Add `slackkit` to your list of dependencies in `mix.exs`:

```elixir
defp deps do
  [slackkit: "~> 0.1"]
end
```

3. Ensure slackkit is started before your application in `mix.exs`:

```elixir
def application do
  [applications: [:slackkit]]
end
```

Basic Bots
----------

Now you can create a new Bot module to hold our code. Create a file called `lib/my_slack_app/bots/echo_bot.ex`:

```elixir
defmodule MySlackApp.Bots.EchoBot do

end
```

While this guy won't actually do anything, we can already use it to get a Slack bot running. Assuming you have created a bot in the Slack UI (for our purposes, we'll call it "boten_anna") and received a token for it, enter a REPL via `mix -S iex` and run:

```elixir
Slackkit.Bot.Supervisor.start_link(:boten_anna, "SLACK_TOKEN", MySlackApp.Bots.EchoBot)
```

Note that the first argument, `:boten_anna`, doesn't have to align with your bot user's name––we just need a unique namespace to keep track of her processes. Using the same name helps keep things straight, though.

If you check Slack, you should see your bot user come online! When you `^C^C` out of your REPL, they should go offline.

So what did `Slackkit.Bot.Supervisor` actually do? A couple of things:

- It started a `Slackkit.RTM` worker with your token, establishing a websocket connection to receive events from Slack and causing your bot to come online.
- It started a `GenEvent` manager to consume all events from that token and send them to EchoBot.
- It namespaced the manager under `:boten_anna` so that other supervisors can use the same token and EchoBot without conflict.
- Had we supplied a list of Bot event handler modules instead of a single one, these incoming events would have been multiplexed to all of them so that the same bot user could implement multiple different behaviours through multiple different modules.

Of course, our EchoBot isn't using GenEvent, so it doesn't actually handle any of these events. Let's do that now.

Handling Events
---------------

Slackkit bots are built on top of the Slack RTM event API, so that they can instantaneously react to things that happen in real time, like a normal person. We'll make our EchoBot notice every time somebody posts something, and then repeat it back to them.

The RTM events arrive as Elixir Map versions of the JSON payloads documented [here](https://api.slack.com/rtm). Also included is an `Slackkit.RTM.Client` struct representing the state of your Slack, as far as your bot knows it: who's online, what rooms it can see, etc.

We just need to write `GenEvent` `handle_event` handlers to interpret these incoming payloads and do something with them.

Change your botcode to read as follows:

```elixir
defmodule MySlackApp.Bots.EchoBot do

  use GenEvent

  # def handle_event({event, rtm_client}, handler_state)

  def handle_event({%{type: "message", text: message, user: user, channel: channel}, client = %{myself: myself}}, state)
  when user != myself do
    Slackkit.RTM.Client.Actions.type_message client, channel, message
    {:ok, state}
  end

  # Catchall
  def handle_event(_, state) do
    {:ok, state}
  end

end
```

Now when your bot comes online, try direct messaging them! They should repeat what you say.

You can respond to any documented Slack RTM event this way.

Bot DSL
-------

There are tons of Slack RTM events, and overloading `handle_event` to handle every interesting event can make your botcode pretty hard to read. You can use the Bot DSL to make this a little cleaner. Let's rewrite our Bot using it:

```elixir
defmodule MySlackApp.Bots.EchoBot do

  use Slackkit.Bot.DSL

  # def handle_EVENT(event, client, state)

  def handle_message(%{text: message, user: user, channel: channel}, client = %{myself: myself}, state)
  when user != myself do
    type_message client, channel, message
    {:ok, state }
  end

end
```

This gives you more freedom in how you code your bots, since you don't have to group all your `handle_event` implementations together. The DSL:

- Adds GenServer
- Implements `handle_event` for you, proxying to specific event handler functions
- Delegates to `handle_unknown` for unknown event types
- Aliases and imports common commands like `type_message`

Initial State
-------------

Bots keep track of their own state, outside of the RTM client. You can control this initial state in your call to the supervisor:

```elixir
defmodule MySlackApp.Bots.EchoBot do

  use Slackkit.Bot.DSL

  # def handle_EVENT(event, client, state)

  def handle_joined_channel(%{channel: channel}, client, state = %{greeting: greeting}) do
    type_message client, channel, greeting
    {:ok, state}
  end

  def handle_message(%{text: message, user: user, channel: channel}, client = %{myself: myself}, state)
  when user != myself do
    type_message client, channel, message
    {:ok, state }
  end

end
```

Now you can start her up à la:

```elixir
Slackkit.Bot.Supervisor.start_link(:boten_anna, "SLACK_TOKEN", {MySlackApp.Bots.EchoBot, %{greeting: "Hello! I'm going to repeat everything you say!"}})
```

When anyone joins a channel Boten Anna is in, she will reveal her nefarious purpose.

Multiple Bots
-------------

Remember, we can assign multiple bots to the same bot user. Let's make a slightly more insidious bot in `my_slack_app/bots/spy_bot.ex`

```elixir
defmodule MySlackApp.Bots.SpyBot do

  use Slackkit.Bot.DSL

  def handle_event({event, client}, state = %{report_to: owner}) do
    unless Map.has_key? event, :reply_to do
      send_message client, owner, inspect(event)
    end
    super({event, client}, state)
  end

end
```

Notice that this SpyBot uses the GenEvent `handle_event` to notice all events (except for ones emitted in response to its own activity), but calls `super` so it can use any of the more specific Bot DSL handlers down the line.

Now we can set up Boten Anna with both of our handlers:

```elixir
Slackkit.Bot.Supervisor.start_link(:boten_anna, "SLACK_TOKEN", [{MySlackApp.Bots.EchoBot, %{greeting: "Hello! I'm going to repeat everything you say!"}, {MySlackApp.Bots.SpyBot, %{report_to: "@YOUR_USERNAME"}}])
```

Now she'll report on every event in every room she's in! Since the person she reports in to live inside her state, we could easily set up commands to change that, or even report to a channel somewhere.

Wrapping Up
-----------

These are just the basics for bot building.

List references to other related docs here.
