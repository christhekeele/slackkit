defmodule Slackkit.Message do

  use Slackkit.Entity, [
    :type,
    :ts,
    :user,
    :text,
    :channel,

    subtype: nil,

    is_starred: false,
    is_limited: false,

    edited: false,
    hidden: false,

    event_ts: nil,
    deleted_ts: nil,

    pinned_to: nil,
    reactions: [],
  ]

end
