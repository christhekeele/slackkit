defmodule Slackkit.Channel do

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :created,
    :creator,
    :is_archived,
    :is_general,
    :members,
    :topic,
    :purpose,
    :is_member,
    :last_read,
    :latest,
    :unread_count,
    :unread_count_display
  ]

end
