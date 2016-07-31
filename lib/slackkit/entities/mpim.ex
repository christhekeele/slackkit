defmodule Slackkit.MPIM do

  use Slackkit.Entity, [
    :id,
    :name,
    :created,
    :creator,
    :last_read,
    latest: %{},
    unread_count: 0,
    unread_count_display: 0,
    members: [],
    is_mpim: true,
    is_group: false,
    is_channel: false,
    is_usergroup: false,
  ]

  do_serialization

end
