defmodule Slackkit.RTM.Event do

  def new(client, data) do
    { :ok, data |> tag |> Map.put(:client, client) }
  end

  @events [
    hello: [type: "hello"],
    joined_channel: [type: "message", subtype: "channel_join"],
    left_channel: [type: "message", subtype: "channel_leave"],
    joined_group: [type: "message", subtype: "group_join"],
    left_group: [type: "message", subtype: "group_leave"],

    channel_created: [type: "channel_created"],
    channel_join: [type: "channel_joined"],
    channel_rename: [type: "channel_rename"],
    channel_archive: [type: "channel_archive"],
    channel_unarchive: [type: "channel_unarchive"],
    channel_leave: [type: "channel_left"],

    im_created: [type: "im_created"],

    group_joined: [type: "group_joined"],
    group_rename: [type: "group_rename"],
    group_archive: [type: "group_archive"],
    group_unarchive: [type: "group_unarchive"],
    group_leave: [type: "group_left"],

    team_join: [type: "team_join"],
    team_rename: [type: "team_rename"],

    presence_change: [type: "presence_change"],
    user_change: [type: "user_change"],

    bot_added: [type: "bot_added"],
    bot_changed: [type: "bot_changed"],
  ]

  @events |> Enum.map( fn {name, matching} ->
    def tag(data = unquote({:%{}, [], matching})) do
      Map.put data, :tag, unquote(name)
    end
  end)

  def tag(data) do
    Map.put data, :tag, :unknown
  end

  def events do
    Map.keys(@events) ++ [:unknown]
  end

  def event_types, do: @events

end
