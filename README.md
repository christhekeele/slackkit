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

Receiving data:

- `Slackkit.Hook` for monitoring for specific public messages with Outgoing Webhooks
- `Slackkit.Command` for receiving to explicit user instructions via Slash Commands

Sending data:

- `Slackkit.Actions` for triggering high-level common actions within Slack
- `Slackkit.API` for sending general instructions to slack via the Web API
- `Slackkit.Message` for authoring simple or richly-formatted messages via Incoming Webhooks

Composing messages:
- `Slackkit.Message.Sigils` Message DSL
- `Slackkit.Message.Builder` Message DSL
- `Slackkit.Reference` for dealing with Channel and User representations
- `Slackkit.Attachment` attaching payloads to Messages
- `Slackkit.Button` for building Interactive Button workflows
- `Slackkit.Emoji` for emoji

Interacting with data:

- `Slackkit.User` for taking actions on behalf of a User
- `Slackkit.Bot` for building Bots that can notice any Slack event
- `Slackkit.Interaction` for responding to Interactive Button input

Utilities:

- `Slackkit.Endpoint` for creating HTTP endpoints for receiving Slack data
- `Slackkit.Socket` for establishing websocket connections with the Slack RTM API
- `Slackkit.Auth` for performing OAuth handshakes
