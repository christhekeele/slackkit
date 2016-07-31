defmodule Slackkit.Bot do

  use Slackkit.Entity, [
    :id,
    :deleted,
    :name,
    :icons,
  ]

  do_serialization

end
