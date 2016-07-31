defmodule Slackkit.File.Comment do

  use Slackkit.Entity, [
    :id,
    :created,
    :timestamp,
    :user,
    :comment,
    :channel
  ]

  do_serialization

end
