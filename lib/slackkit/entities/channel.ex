defmodule Slackkit.Channel do

  alias Slackkit.Channel.Purpose
  alias Slackkit.Channel.Topic

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

  def spec, do: %__MODULE__{purpose: Purpose.spec, topic: Topic.spec}

end
