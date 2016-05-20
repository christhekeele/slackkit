defmodule Slackkit.RTM.Client.Actions do

  alias Slackkit.RTM.Client.Lookups


  @doc """
  Mimics typing `text` to `channel` for the given `client` connection. Effectively
  just fires the typing indicator and then sends the message `duration` milliseconds later.
  """
  def type_message(client, channel, message, duration \\ 1500) do
    indicate_typing client, channel
    :timer.sleep duration # block handler from returning, send_after doesn't
    send_message client, channel, message
  end

  @doc """
  Sends `text` to `channel` for the given `client` connection.  `channel` can be
  a string in the format of `"#CHANNEL_NAME"`, `"@USER_NAME"`, or any ID that
  Slack understands.
  """
  def send_message(client, channel = "#" <> channel_name, text) do
    channel_id = Lookups.lookup_channel_id(client, channel)

    if channel_id do
      send_message(client, text, channel_id)
    else
      raise ArgumentError, "channel ##{channel_name} not found"
    end
  end
  def send_message(client, user = "@" <> _user_name, text) do
    direct_message_id = Lookups.lookup_direct_message_id(client, user)

    if direct_message_id do
      send_message(client, text, direct_message_id)
    else
      open_im_channel(
        client.token,
        Lookups.lookup_user_id(client, user),
        fn id -> send_message(client, text, id) end,
        fn _reason -> :delivery_failed end
      )
    end
  end
  def send_message(client, channel, text) do
    %{
      type: "message",
      text: text,
      channel: channel
    }
      |> JSX.encode!
      |> send_raw(client)
  end

  @doc """
  Notifies Slack that the current user is typing in `channel`.
  """
  def indicate_typing(client, channel) do
    %{
      type: "typing",
      channel: channel
    }
      |> JSX.encode!
      |> send_raw(client)
  end

  @doc """
  Sends Slack a ping message with optional `payload`.
  """
  def send_ping(client, payload \\ []) do
    %{
      type: "ping"
    }
      |> Dict.merge(payload)
      |> JSX.encode!
      |> send_raw(client)
  end

  @doc """
  Sends raw JSON to a given socket.
  """
  # def send_raw(json, %{socket: socket, client: client}) do
  def send_raw(json, %{socket: socket}) do
    :websocket_client.send(socket, {:text, json})
  end

  defp open_im_channel(token, user_id, on_success, on_error) do
    im_open = HTTPoison.post(
      "https://slack.com/api/im.open",
      {:form, [token: token, user: user_id]}
    )
    case im_open do
      {:ok, response} ->
        case JSX.decode!(response.body, [{:labels, :atom}]) do
          %{ok: true, channel: %{id: id}} -> on_success.(id)
          _ -> on_error.()
        end
      {:error, reason} -> on_error.(reason)
    end
  end

end
