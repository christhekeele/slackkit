defmodule Slackkit.RTM.Client.Lookups do

    alias Slack.Client

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
