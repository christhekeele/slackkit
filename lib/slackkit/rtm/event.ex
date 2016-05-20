defmodule Slackkit.RTM.Event do

  def new(client, json) do
    { :ok, %{ event: json, client: client } }
    # { :ok, %{ event: new(json), client: client } }
  end

#   def new(%{type: "channel_created", channel: channel}) do
#     track(client, :channel, channel)
#   end
#
#   def new(%{type: "channel_joined", channel: channel}) do
#     join(client, :channel, channel)
#   end
#
#   def new(%{type: "message", subtype: "channel_join", channel: channel, user: user}) do
#     joined(client, :channel, channel, user)
#   end
#
#   def new(%{type: "channel_rename", channel: channel}) do
#     rename(client, :channel, channel)
#   end
#
#   def new(%{type: "channel_archive", channel: channel}) do
#     archive(client, :channel, channel)
#   end
#
#   def new(%{type: "channel_unarchive", channel: channel}) do
#     unarchive(client, :channel, channel)
#   end
#
#   def new(%{type: "message", subtype: "channel_leave", channel: channel, user: user}) do
#     left(client, :channel, channel, user)
#   end
#
#   def new(%{type: "channel_left", channel: channel}) do
#     leave(client, :channel, channel)
#   end
#
# # IMS
#
#   def new(%{type: "im_created", channel: im}) do
#     track(client, :im, im)
#   end
#
# # GROUPS
#
#   def new(%{type: "group_joined", channel: group}) do
#     join(client, :group, group)
#   end
#
#   def new(%{type: "message", subtype: "group_join", channel: group, user: user}) do
#     joined(client, :group, group, user)
#   end
#
#   def new(%{type: "group_rename", channel: group}) do
#     rename(client, :group, group)
#   end
#
#   def new(%{type: "group_archive", channel: group}) do
#     archive(client, :group, group)
#   end
#
#   def new(%{type: "group_unarchive", channel: group}) do
#     unarchive(client, :group, group)
#   end
#
#   def new(%{type: "message", subtype: "group_leave", channel: group, user: user}) do
#     left(client, :group, group, user)
#   end
#
#   def new(%{type: "group_left", channel: group}) do
#     leave(client, :group, group)
#   end
#
# # TEAM
#
#   def new(%{type: "team_join", user: user}) do
#     track(client, :user, user)
#   end
#
#   def new(%{type: "team_rename", name: name}) do
#     rename(client, :team, name)
#   end
#
# # USERS
#
#   def new(%{type: "presence_change", user: user, presence: presence}) do
#     change(client, :user, user, presence)
#   end
#
#   def new(%{type: "user_change", user: user}) do
#     change(client, :user, user)
#   end
#
# # BOTS
#
#   def new(%{type: "bot_added", bot: bot}) do
#     track(client, :bot, bot)
#   end
#
#   def new(%{type: "bot_changed", bot: bot}) do
#     change(client, :bot, bot)
#   end
#
# # CATCHALL
#
#   def new(event) do
#     client
#   end

end
