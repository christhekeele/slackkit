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
  
  def process(client, json) do
    case update client, json do
      {:ok, client} -> case Slackkit.RTM.Event.new client, json do
        {:ok, event} -> case GenEvent.notify client.manager, event do
          :ok -> client
        end
      end
    end
  end
  
  def update(client, %{type: "channel_created", channel: channel}) do
    { :ok, track(client, :channel, channel) }
  end
  
  def update(client, %{type: "channel_joined", channel: channel}) do
    { :ok, join(client, :channel, channel) }
  end

  def update(client, %{type: "message", subtype: "channel_join", channel: channel, user: user}) do
    { :ok, joined(client, :channel, channel, user) }
  end

  def update(client, %{type: "channel_rename", channel: channel}) do
    { :ok, rename(client, :channel, channel) }
  end
  
  def update(client, %{type: "channel_archive", channel: channel}) do
    { :ok, archive(client, :channel, channel) }
  end
  
  def update(client, %{type: "channel_unarchive", channel: channel}) do
    { :ok, unarchive(client, :channel, channel) }
  end
  
  def update(client, %{type: "message", subtype: "channel_leave", channel: channel, user: user}) do
    { :ok, left(client, :channel, channel, user) }
  end

  def update(client, %{type: "channel_left", channel: channel}) do
    { :ok, leave(client, :channel, channel) }
  end
  
# IMS

  def update(client, %{type: "im_created", channel: im}) do
    { :ok, track(client, :im, im) }
  end
  
# GROUPS

  def update(client, %{type: "group_joined", channel: group}) do
    { :ok, join(client, :group, group) }
  end

  def update(client, %{type: "message", subtype: "group_join", channel: group, user: user}) do
    { :ok, joined(client, :group, group, user) }
  end

  def update(client, %{type: "group_rename", channel: group}) do
    { :ok, rename(client, :group, group) }
  end
  
  def update(client, %{type: "group_archive", channel: group}) do
    { :ok, archive(client, :group, group) }
  end
  
  def update(client, %{type: "group_unarchive", channel: group}) do
    { :ok, unarchive(client, :group, group) }
  end
  
  def update(client, %{type: "message", subtype: "group_leave", channel: group, user: user}) do
    { :ok, left(client, :group, group, user) }
  end

  def update(client, %{type: "group_left", channel: group}) do
    { :ok, leave(client, :group, group) }
  end
  
# TEAM

  def update(client, %{type: "team_join", user: user}) do
    { :ok, track(client, :user, user) }
  end

  def update(client, %{type: "team_rename", name: name}) do
    { :ok, rename(client, :team, name) }
  end
  
# USERS

  def update(client, %{type: "presence_change", user: user, presence: presence}) do
    { :ok, change(client, :user, user, presence) }
  end
  
  def update(client, %{type: "user_change", user: user}) do
    { :ok, change(client, :user, user) }
  end
  
# BOTS

  def update(client, %{type: "bot_added", bot: bot}) do
    { :ok, track(client, :bot, bot) }
  end
  
  def update(client, %{type: "bot_changed", bot: bot}) do
    { :ok, change(client, :bot, bot) }
  end
  
# CATCHALL
  
  def update(client, event) do
    { :ok, client }
  end
  
  pluralize_type = fn type ->
    { type, type |> Atom.to_string |> Kernel.<>("s") |> String.to_atom }
  end
    
  @doc """
  Notice when a new Slack object has been created.
  
  Available types: `[:channel, :im, :group, :user, :bot]`
  """
  @spec track(Client.t, Atom.t, Map.t) :: Client.t
  def track(client, type, object)
  
  [:channel, :im, :group, :user, :bot] |> Enum.map(pluralize_type) |> Enum.map( fn {type, plural} ->
    def track(client, unquote(type), object) do
      put_in client, [unquote(plural), object.id], object
    end
  end )
  
  @doc """
  Notices when you join a channel or group.
  
  Available types: `[:channel, :group]`
  """
  @spec join(Client.t, Atom.t, Map.t) :: Client.t
  def join(client, type, object)
  
  def join(client, :channel, channel) do
    client
      |> put_in([:channels, channel.id, :members], channel.members)
      |> put_in([:channels, channel.id, :is_member], true)
  end
  
  def join(client, :group, group) do
    put_in(client, [:groups, group.id], group)
  end
  
  @doc """
  Notices when a user joins a channel or group.
  
  Available types: `[:channel, :group]`
  """
  @spec joined(Client.t, Atom.t, Map.t, Map.t) :: Client.t
  def joined(client, type, object, user)
  
  [:channel, :group] |> Enum.map(pluralize_type) |> Enum.map( fn {type, plural} ->
    def joined(client, unquote(type), object, user) do
      update_in(client, [unquote(plural), object, :members], &(Enum.uniq([user | &1])))
    end
  end )
  
  @doc """
  Notices when you leave a channel or group.
  
  Available types: `[:channel, :group]`
  """
  @spec leave(Client.t, Atom.t, Map.t) :: Client.t
  def leave(client, type, object)
  
  def leave(client, :channel, channel) do
    put_in(client, [:channels, channel, :is_member], false)
  end
  
  def leave(client, :group, group) do
    update_in(client, [:groups], &(Map.delete(&1, group)))
  end
  
  @doc """
  Notices when a user left a channel or group.
  
  Available types: `[:channel, :group]`
  """
  @spec left(Client.t, Atom.t, Map.t, Map.t) :: Client.t
  def left(client, type, object, user)
  
  [:channel, :group] |> Enum.map(pluralize_type) |> Enum.map( fn {type, plural} ->
    def left(client, unquote(type), object, user) do
      update_in(client, [unquote(plural), object, :members], &(&1 -- [user]))
    end
  end )
  
  @doc """
  Notices when a channel or group is archived.
  
  Available types: `[:channel, :group]`
  """
  @spec archive(Client.t, Atom.t, Map.t) :: Client.t
  def archive(client, type, object)
  
  [:channel, :group] |> Enum.map(pluralize_type) |> Enum.map( fn {type, plural} ->
    def archive(client, unquote(type), object) do
      put_in(client, [unquote(plural), object, :is_archived], true)
    end
  end )
  
  @doc """
  Notices when a channel or group is archived.
  
  Available types: `[:channel, :group]`
  """
  @spec unarchive(Client.t, Atom.t, Map.t) :: Client.t
  def unarchive(client, type, object)
  
  [:channel, :group] |> Enum.map(pluralize_type) |> Enum.map( fn {type, plural} ->
    def unarchive(client, unquote(type), object) do
      put_in(client, [unquote(plural), object, :is_archived], false)
    end
  end )
  
  @doc """
  Notices when a channel or group's name has changed.
  
  Additionally notices when the team's name changes.
  
  Available types: `[:channel, :group, :team]`
  """
  
  @spec rename(Client.t, Atom.t, String.t) :: Client.t
  def rename(client, :team, name) do
    put_in(client, [:team, :name], name)
  end
  
  @spec rename(Client.t, Atom.t, String.t) :: Client.t
  [:channel, :group] |> Enum.map(pluralize_type) |> Enum.map( fn {type, plural} ->
    def rename(client, unquote(type), object) do
      put_in(client, [unquote(plural), object.id, :name], object.name)
    end
  end )
  
  @doc """
  Notices when a bot or user changes.
  
  Also notices when a user's presence has changed.
  
  Available types: `[:user, :bot]`
  """
  
  @spec change(Client.t, Atom.t, Map.t) :: Client.t
  [:user, :bot] |> Enum.map(pluralize_type) |> Enum.map( fn {type, plural} ->
    def change(client, unquote(type), object) do
      put_in(client, [unquote(plural), object.id], object)
    end
  end )
  
  @spec change(Client.t, Atom.t, Map.t, String.t) :: Client.t
  def change(client, :user, user, presence) do
    put_in(client, [:users, user, :presence], presence)
  end
  
  @doc """
  Converts between Slack ID formats.
  
  Available conversions: 
    - `:user: [:id, :im, :name]``
    - `:channel: [:id, :name]``
  """
  @spec lookup(Client.t, Atom.t, Atom.t, String.t) :: Map.t
  def lookup(client, type, format, name)
    
  def lookup(_client, :user, :id, id = "U" <> _id), do: id
  def lookup(client, :user, :id, im = "D" <> _id) do
    name = lookup(client, :user, :name, im)
    lookup(client, :user, :id, name)
  end
  def lookup(client, :user, :id, "@" <> user_name) do
    client.users
      |> Map.values
      |> Enum.find(%{ }, fn user -> user.name == user_name end)
      |> Map.get(:id)
  end
  
  def lookup(_client, :user, :im, im = "D" <> _id), do: im
  def lookup(client, :user, :im, name = "@" <> _id) do
    id = lookup(client, :user, :id, name)
    lookup(client, :user, :im, id)
  end
  def lookup(client, :user, :im, id = "U" <> _id) do
    client.ims
      |> Map.values
      |> Enum.find(%{ }, fn im -> im.user == id end)
      |> Map.get(:id)
  end
  
  def lookup(_client, :user, :name, name = "@" <> _id), do: name
  def lookup(client, :user, :name, im_id = "D" <> _id) do
    lookup(client, :user, :name, client.ims[im_id].user)
  end
  def lookup(client, :user, :name, user_id = "U" <> _id) do
    "@" <> client.users[user_id].name
  end
  
  def lookup(_client, :channel, :id, id = "C" <> _id), do: id
  def lookup(client, :channel, :id, "#" <> channel_name) do
    client.channels
      |> Map.values
      |> Enum.find(fn channel -> channel.name == channel_name end)
      |> Map.get(:id)
  end
  
  def lookup(_client, :channel, :name, name = "#" <> _id), do: name
  def lookup(client, :channel, :name, channel_id = "C" <> _id) do
    "#" <> client.channels[channel_id].name
  end
  
  def lookup(_client, _type, _format, _id) do
    nil
  end
  
end
