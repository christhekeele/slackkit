defmodule Slackkit.RTM.Client.Handler do

  import Slackkit.RTM.Client.Reactions

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

  def update(client, _) do
    { :ok, client }
  end

end
