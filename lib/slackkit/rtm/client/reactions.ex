defmodule Slackkit.RTM.Client.Reactions do

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

end
