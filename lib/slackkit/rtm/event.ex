defmodule Slackkit.RTM.Event do

  # defstruct tag: :unknown

  def new(data) do
  # tag struct(__MODULE__, data)
    tag data
  end

  @event_matches [
    # Maps our event names to function clause matches for macro generation.
    # We normalize event names as such:
    #  - Most events use the past tense
    #  - Events triggered by current user activity use the active voice (verbed_noun)
    #  - Observed events use the passive tense (noun_verbed)

    # The client has successfully connected to the server
    hello: [type: "hello"],

    # Message subtypes
    # These are special insofar as they should to be displayed immediately
    # to any client rather than simply being observered in the background.

    # A message was posted by an integration
    bot_message: [type: "message", subtype: "bot_message"],
    # A /me message was sent
    me_message: [type: "message", subtype: "me_message"],
    # A message was changed
    message_changed: [type: "message", subtype: "message_changed"],
    # A message was deleted
    message_deleted: [type: "message", subtype: "message_deleted"],
    # A team member joined a channel
    channel_joined: [type: "message", subtype: "channel_join"],
    # A team member left a channel
    channel_left: [type: "message", subtype: "channel_leave"],
    # A channel topic was updated
    channel_topic_changed: [type: "message", subtype: "channel_topic"],
    # A channel purpose was updated
    channel_purpose_changed: [type: "message", subtype: "channel_purpose"],
    # A channel was renamed
    channel_renamed: [type: "message", subtype: "channel_name"],
    # A channel was archived
    channel_archived: [type: "message", subtype: "channel_archive"],
    # A channel was unarchived
    channel_unarchived: [type: "message", subtype: "channel_unarchive"],
    # A team member joined a group
    group_joined: [type: "message", subtype: "group_join"],
    # A team member left a group
    group_left: [type: "message", subtype: "group_leave"],
    # A group topic was updated
    group_topic_changed: [type: "message", subtype: "group_topic"],
    # A group purpose was updated
    group_purpose_changed: [type: "message", subtype: "group_purpose"],
    # A group was renamed
    group_renamed: [type: "message", subtype: "group_name"],
    # A group was archived
    group_archived: [type: "message", subtype: "group_archive"],
    # A group was unarchived
    group_unarchived: [type: "message", subtype: "group_unarchive"],
    # A file was shared into a channel
    file_shared: [type: "message", subtype: "file_share"],
    # A comment was added to a file
    file_comment_on: [type: "message", subtype: "file_comment"],
    # A file was mentioned in a channel
    file_mentioned: [type: "message", subtype: "file_mention"],
    # An item was pinned in a channel
    item_pinned: [type: "message", subtype: "pinned_item"],
    # An item was unpinned from a channel
    item_unpinned: [type: "message", subtype: "unpinned_item"],
    # Catch-all
    # A message was sent to a channel
    message: [type: "message"],

    # A channel member is typing a message
    user_typing: [type: "user_typing"],

    # Your channel read marker was updated
    channel_marked: [type: "channel_marked"],

    # A team channel was created
    channel_created: [type: "channel_created"],

    # You joined a channel
    joined_channel: [type: "channel_joined"],

    # You left a channel
    left_channel: [type: "channel_left"],

    # A team channel was deleted
    channel_deleted: [type: "channel_deleted"],

    # A team channel was renamed
    channel_renamed: [type: "channel_rename"],

    # A team channel was archived
    channel_archived: [type: "channel_archive"],

    # A team channel was unarchived
    channel_unarchived: [type: "channel_unarchive"],

    # Bulk updates were made to a channel's history
    channel_history_changed: [type: "channel_history_changed"],

    # Do not Disturb settings changed for the current user
    updated_dnd: [type: "dnd_updated"],

    # Do not Disturb settings changed for a team member
    dnd_updated: [type: "dnd_updated_user"],

    # A direct message channel was created
    im_created: [type: "im_created"],

    # You opened a direct message channel
    opened_im: [type: "im_open"],

    # You closed a direct message channel
    closed_im: [type: "im_close"],

    # A direct message read marker was updated
    im_marked: [type: "im_marked"],

    # Bulk updates were made to a DM channel's history
    im_history_changed: [type: "im_history_changed"],

    # You joined a private group
    joined_group: [type: "group_joined"],

    # You left a private group
    left_group: [type: "group_left"],

    # You opened a group channel
    opened_group: [type: "group_open"],

    # You closed a group channel
    closed_group: [type: "group_close"],

    # A private group was archived
    group_archived: [type: "group_archive"],

    # A private group was unarchived
    group_unarchived: [type: "group_unarchive"],

    # A private group was renamed
    group_renamed: [type: "group_rename"],

    # A private group read marker was updated
    group_marked: [type: "group_marked"],

    # Bulk updates were made to a group's history
    group_history_changed: [type: "group_history_changed"],

    # A file was created
    file_created: [type: "file_created"],

    # A file was shared
    file_shared: [type: "file_shared"],

    # A file was unshared
    file_unshared: [type: "file_unshared"],

    # A file was made public
    file_made_public: [type: "file_public"],

    # A file was made private
    file_made_private: [type: "file_private"],

    # A file was changed
    file_changed: [type: "file_change"],

    # A file was deleted
    file_deleted: [type: "file_deleted"],

    # A file comment was added
    file_comment_added: [type: "file_comment_added"],

    # A file comment was edited
    file_comment_edited: [type: "file_comment_edited"],

    # A file comment was deleted
    file_comment_deleted: [type: "file_comment_deleted"],

    # A pin was added to a channel
    pin_added: [type: "pin_added"],

    # A pin was removed from a channel
    pin_removed: [type: "pin_removed"],

    # A team member's presence changed
    presence_changed: [type: "presence_change"],

    # You manually updated your presence
    changed_presence: [type: "manual_presence_change"],

    # You have updated your preferences
    changed_preferences: [type: "pref_change"],

    # A team member's data has changed
    user_changed: [type: "user_change"],

    # A new team member has joined
    team_joined: [type: "team_join"],

    # A team member has starred an item
    star_added: [type: "star_added"],

    # A team member removed a star
    star_removed: [type: "star_removed"],

    # A team member has added an emoji reaction to an item
    reaction_added: [type: "reaction_added"],

    # A team member removed an emoji reaction
    reaction_removed: [type: "reaction_removed"],

    # A team custom emoji has been added or changed
    emoji_changed: [type: "emoji_changed"],

    # A team slash command has been added or changed
    commands_changed: [type: "commands_changed"],

    # The team billing plan has changed
    team_plan_changed: [type: "team_plan_change"],

    # A team preference has been updated
    team_pref_changed: [type: "team_pref_change"],

    # The team name has changed
    team_renamed: [type: "team_rename"],

    # The team domain has changed
    team_domain_changed: [type: "team_domain_change"],

    # The team email domain has changed
    email_domain_changed: [type: "email_domain_changed"],

    # Team profile fields have been updated
    team_profile_changed: [type: "team_profile_change"],

    # Team profile fields have been deleted
    team_profile_deleted: [type: "team_profile_delete"],

    # Team profile fields have been reordered
    team_profile_reordered: [type: "team_profile_reorder"],

    # An integration bot was added
    bot_added: [type: "bot_added"],

    # An integration bot was changed
    bot_changed: [type: "bot_changed"],

    # The list of accounts a user is signed into has changed
    accounts_changed: [type: "accounts_changed"],

    # The team is being migrated between servers
    team_migration_started: [type: "team_migration_started"],

    # Experimental
    reconnect_url: [type: "reconnect_url"],

    # A User Group has been added to the team
    subteam_created: [type: "subteam_created"],

    # An existing User Group has been updated or its members changed
    subteam_updated: [type: "subteam_updated"],

    # You have been added to a User Group
    joined_subteam: [type: "subteam_self_added"],

    # You have been removed from a User Group
    left_subteam: [type: "subteam_self_removed"],

    # Catchall: event not recognized
    unknown: [],

  ]

  @event_matches |> Enum.map( fn {name, match} ->
    map_match = {:%{}, [], match}
    defp tag(data = unquote(map_match)) do
      Map.put data, :tag, unquote(name)
    end
  end)

  def matches, do: @event_matches

  def types, do: unquote @event_matches |> Keyword.keys

  def callbacks, do: unquote @event_matches |> Keyword.keys |> Enum.map( fn type ->
    String.to_atom("handle_" <> Atom.to_string(type))
  end ) |> Macro.escape

  def callback_types, do: unquote @event_matches |> Keyword.keys |> Enum.map( fn type ->
    { type, String.to_atom("handle_" <> Atom.to_string(type)) }
  end ) |> Macro.escape

end
