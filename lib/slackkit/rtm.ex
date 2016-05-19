defmodule JSX.DecodeError do
  defexception [:reason, :string]
  
  def message(%JSX.DecodeError{reason: reason, string: string}) do
    "JSX could not decode string for reason: `:#{reason}`, string given:\n#{string}"
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
      {:error, %HTTPoison.Error{reason: :connect_timeout}} ->
        {:error, "Timed out while connecting to the Slack RTM API"}
      {:error, %HTTPoison.Error{reason: :nxdomain}} ->
        {:error, "Could not connect to the Slack RTM API"}
      {:error, %JSX.DecodeError{string: "You are sending too many requests. Please relax."}} ->
        {:error, "Too many connection requests sent to Slack RTM at once."}
      {:error, error} ->
        {:error, error}
      {:ok, success} -> 
        {:ok, success}
    end
  end
  
  defp link_client(token, manager) do
    case HTTPoison.get(@url <> token) do
      {:ok, %HTTPoison.Response{body: body}} ->
        case JSX.decode body, [{:labels, :atom}] do
          {:ok, json} -> 
            client = %{ client(json) | manager: manager }
            url = String.to_char_list(json.url)
            :websocket_client.start_link(url, __MODULE__, client)
          {:error, reason} -> {:error, %JSX.DecodeError{reason: reason, string: body}}
        end
      {:error, reason} -> {:error, reason}
    end
  end
  
  defp client(json), do: %Slackkit.RTM.Client{
    me: json.self,
    team: json.team,
    bots: rtm_list_to_map(json.bots),
    channels: rtm_list_to_map(json.channels),
    groups: rtm_list_to_map(json.groups),
    users: rtm_list_to_map(json.users),
    ims: rtm_list_to_map(json.ims)
  }
  
  defp rtm_list_to_map(list) do
    Enum.reduce(list, %{}, fn (item, map) ->
      Map.put(map, item.id, item)
    end)
  end

  def onconnect(_req, state) do
    {:ok, state} # Ping time?
  end
  
  def init(client) do
    {:once, client}
  end

  def websocket_handle({:ping, payload}, _connection, client) do
    {:reply, {:pong, payload}, client}
  end

  def websocket_handle({:pong, payload}, _connection, client) do
    # {:ok, {:pong, payload}, client}
    {:ok, client}
  end

  def websocket_handle({:text, data}, _connection, client) do
    IO.puts "handling text"
    client = Slackkit.RTM.Client.process(client, parse_json(data))
    IO.puts "handled client"
    { :ok, client }
    # { :ok, Slackkit.RTM.Client.process(client, parse_json(data)) }
  end

  def websocket_info(:start, _connection, client) do
    {:ok, client}
  end

  def websocket_info(message, _connection, client) do
    {:ok, client}
  end
    
  def websocket_terminate(reason, _connection, client) do
  end
  
  def ondisconnect({:remote, :closed}, state) do
    {:reconnect, state}
  end

  defp parse_json(binstring) do
    binstring
      |> :binary.split(<<0>>)
      |> List.first
      |> JSX.decode!([{:labels, :atom}])
  end
  
end