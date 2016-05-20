defmodule Slackkit.RTM.Client do

  defstruct [
    manager:  nil,
    me:       nil,
    team:     nil,
    bots:     %{},
    channels: %{},
    groups:   %{},
    users:    %{},
    ims:      %{},
  ]

  @behaviour Access

  @type key :: any
  @type value :: any

  @doc """
  Implements fetch/2 for Access protocol.
  """
  @spec fetch(Client.t, key) :: value
  def fetch(client, key)
  defdelegate fetch(client, key), to: Map

  @doc """
  Implements get_and_update/3 for Access protocol.
  """
  @spec get_and_update(Client.t, key, (value -> {value, value})) :: Client.t
  def get_and_update(client, key, function)
  defdelegate get_and_update(client, key, function), to: Map

  def process(client, payload) do
    case Slackkit.RTM.Client.Handler.update client, payload do
      {:ok, client} -> case Slackkit.RTM.Event.new payload do
        event -> case GenEvent.notify client.manager, {event, client} do
          :ok -> client
        end
      end
    end
  end

end
