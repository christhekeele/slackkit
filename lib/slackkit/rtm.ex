defmodule Poison.DecodeError do
  defexception [:reason, string: ""]

  def message(%Poison.DecodeError{reason: reason, string: string}) do
    "Poison could not decode string for reason: `:#{reason}`, string given:\n#{string}"
  end
end

defmodule Slackkit.Auth.Error do
  defexception [:reason]

  def message(%Slackkit.Auth.Error{reason: reason}) do
    "Could not authenticate with Slack, got error: `#{reason}`."
  end
end

defmodule Slackkit.RTM do
  @moduledoc """
  Hooks into Slack's Real Time Message event stream.

  Connects to a Slack RTM websocket as the user identified by the given `token`,
  and emits `RTM.Event`s through the given GenEvent manager.

  The GenEvent manager is assumed to be started before Slackkit.RTM is.
  """

  @behaviour :websocket_client

  @url "https://slack.com/api/rtm.start?token="

  def start_link(token, manager) do
    do_start token, manager
  end

  def start(token, manager) do
    do_start token, manager
  end

  defp do_start(token, manager) do
    case link_client token, manager do
      {:ok, success} ->
        {:ok, success}
      {:error, error} ->
        {:error, format_exception(error)}
    end
  end

  # defp format_exception(%HTTPoison.Error{reason: :connect_timeout}) do
  #   "Timed out while connecting to the Slack RTM API."
  # end
  #
  # defp format_exception(%HTTPoison.Error{reason: :nxdomain}) do
  #   "Could not connect to the Slack RTM API."
  # end

  defp format_exception(%Poison.DecodeError{string: "You are sending too many requests. Please relax."}) do
    "Too many connection requests sent to Slack RTM at once."
  end

  defp format_exception(%Slackkit.Auth.Error{reason: "invalid_auth"}) do
    "Could not authenticate with Slack RTM API: bad token."
  end

  defp format_exception(%{reason: reason}) do
    reason
  end

  defp format_exception(%{message: message}) do
    message
  end

  defp format_exception(other) do
    other
  end

  defp link_client(token, manager) do
    # case HTTPoison.get(@url <> token) do
    #   {:ok, %HTTPoison.Response{body: body}} ->
    #     case Poison.decode(body, keys: :atoms) do
    #       {:ok, %{error: reason, ok: false} } ->
    #         {:error, %Slackkit.Auth.Error{reason: reason}}
    #       {:ok, json} ->
    #         # client = %{ client(json) | manager: manager }
    #         client = %{ client(json) | manager: manager, token: token }
    #         url = String.to_char_list(json.url)
    #         :websocket_client.start_link(url, __MODULE__, client)
    #       {:error, :invalid} -> {:error, %Poison.DecodeError{reason: :invalid, string: body}}
    #       {:error, {:invalid, token}} -> {:error, %Poison.DecodeError{reason: :invalid, string: token}}
    #     end
    #   {:error, reason} -> {:error, reason}
    # end
  end

  defp client(json), do: %Slackkit.RTM.Client{
    myself: json.self,
    team: json.team,
    bots: rtm_list_to_map(json.bots),
    channels: rtm_list_to_map(json.channels),
    groups: rtm_list_to_map(json.groups),
    users: rtm_list_to_map(json.users),
    ims: rtm_list_to_map(json.ims),
  }

  defp rtm_list_to_map(list) do
    Enum.reduce(list, %{}, fn (item, map) ->
      Map.put(map, item.id, item)
    end)
  end

  def onconnect(_req, client) do
    # {:ok, client} # Ping time?
    {:ok, %{ client | socket: self }}
  end

  def init(client) do
    {:once, client}
  end

  def websocket_handle({:ping, payload}, _connection, client) do
    {:reply, {:pong, payload}, client}
  end

  def websocket_handle({:pong, _payload}, _connection, client) do
    # {:ok, {:pong, payload}, client}
    {:ok, client}
  end

  def websocket_handle({:text, payload}, _connection, client) do
    { :ok, Slackkit.RTM.Client.process(client, parse_json(payload)) }
  end

  def websocket_info(:start, _connection, client) do
    {:ok, client}
  end

  def websocket_info(_message, _connection, client) do
    {:ok, client}
  end

  def websocket_terminate(_reason, _connection, _client) do
  end

  def ondisconnect({:remote, :closed}, client) do
    {:reconnect, client}
  end

  defp parse_json(binstring) do
    binstring
      |> :binary.split(<<0>>)
      |> List.first
      |> Poison.decode!(keys: :atoms)
  end

end
