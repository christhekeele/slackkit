defmodule Slackkit.RTM.Event do

  # defstruct tag: :unknown

  def new(data) do
  # tag struct(__MODULE__, data)
    tag data
  end

  @event_types [
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
    bot_message: [type: "message", subtype: "bot_message"],

    message: [type: "message", text: Macro.var(:text, __MODULE__)],
  ]

  @event_types |> Enum.map( fn {name, matching} ->
    # struct_matching = {:%, [], [{:__aliases__, [alias: false], [__MODULE__]}, {:%{}, [], matching}]}
    # def tag(data = unquote(struct_matching)) do
    #   %{ data | :tag => unquote(name) }
    # end
    map_matching = {:%{}, [], matching}
    def tag(data = unquote(map_matching)) do
      Map.put data, :tag, unquote(name)
    end
  end)

  def tag(data) do
    # %{ data | :tag => :unknown }
    Map.put data, :tag, :unknown
  end

  def types, do: @event_types

  def events do
    Keyword.keys(types) ++ [:unknown]
  end

  def callbacks do
    events |> Enum.map( fn type ->
      type_to_callback type
    end )
  end

  def callback_types do
    types |> Enum.map( fn { type, matching } ->
      { type_to_callback(type), matching }
    end )
  end

  def event_callbacks do
    events |> Enum.map( fn type ->
      { type, type_to_callback(type) }
    end )
  end

  defp type_to_callback(type) do
    String.to_atom("handle_" <> Atom.to_string(type))
  end

end
