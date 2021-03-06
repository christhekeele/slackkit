defmodule Slackkit.Channel do

  alias Slackkit.Purpose
  alias Slackkit.Topic

  use Slackkit.Entity, [
    :id,
    :name,
    :created,
    :creator,
    :is_archived,
    :is_general,
    :members,
    :is_member,
    :last_read,
    :latest,
    :unread_count,
    :unread_count_display,
    is_mpim: false,
    is_group: false,
    is_channel: true,
    is_usergroup: false,
    topic: Topic.spec,
    purpose: Purpose.spec,
  ]

  do_serialization

end
