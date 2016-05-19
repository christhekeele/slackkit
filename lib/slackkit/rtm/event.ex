defmodule Slackkit.RTM.Event do
  
  def new(client, json) do
    { :ok, %{ data: json, client: client } }
  end
  
#   def apply(%{type: "channel_created", channel: channel}, client) do
#     track(client, :channel, channel)
#   end
#   
#   def apply(%{type: "channel_joined", channel: channel}, client) do
#     join(client, :channel, channel)
#   end
# 
#   def apply(%{type: "message", subtype: "channel_join", channel: channel, user: user}, client) do
#     joined(client, :channel, channel, user)
#   end
# 
#   def apply(%{type: "channel_rename", channel: channel}, client) do
#     rename(client, :channel, channel)
#   end
#   
#   def apply(%{type: "channel_archive", channel: channel}, client) do
#     archive(client, :channel, channel)
#   end
#   
#   def apply(%{type: "channel_unarchive", channel: channel}, client) do
#     unarchive(client, :channel, channel)
#   end
#   
#   def apply(%{type: "message", subtype: "channel_leave", channel: channel, user: user}, client) do
#     left(client, :channel, channel, user)
#   end
# 
#   def apply(%{type: "channel_left", channel: channel}, client) do
#     leave(client, :channel, channel)
#   end
#   
# # IMS
# 
#   def apply(%{type: "im_created", channel: im}, client) do
#     track(client, :im, im)
#   end
#   
# # GROUPS
# 
#   def apply(%{type: "group_joined", channel: group}, client) do
#     join(client, :group, group)
#   end
# 
#   def apply(%{type: "message", subtype: "group_join", channel: group, user: user}, client) do
#     joined(client, :group, group, user)
#   end
# 
#   def apply(%{type: "group_rename", channel: group}, client) do
#     rename(client, :group, group)
#   end
#   
#   def apply(%{type: "group_archive", channel: group}, client) do
#     archive(client, :group, group)
#   end
#   
#   def apply(%{type: "group_unarchive", channel: group}, client) do
#     unarchive(client, :group, group)
#   end
#   
#   def apply(%{type: "message", subtype: "group_leave", channel: group, user: user}, client) do
#     left(client, :group, group, user)
#   end
# 
#   def apply(%{type: "group_left", channel: group}, client) do
#     leave(client, :group, group)
#   end
#   
# # TEAM
# 
#   def apply(%{type: "team_join", user: user}, client) do
#     track(client, :user, user)
#   end
# 
#   def apply(%{type: "team_rename", name: name}, client) do
#     rename(client, :team, name)
#   end
#   
# # USERS
# 
#   def apply(%{type: "presence_change", user: user, presence: presence}, client) do
#     change(client, :user, user, presence)
#   end
#   
#   def apply(%{type: "user_change", user: user}, client) do
#     change(client, :user, user)
#   end
#   
# # BOTS
# 
#   def apply(%{type: "bot_added", bot: bot}, client) do
#     track(client, :bot, bot)
#   end
#   
#   def apply(%{type: "bot_changed", bot: bot}, client) do
#     change(client, :bot, bot)
#   end
#   
# # CATCHALL
#   
#   def apply(event, client) do
#     client
#   end
  
end