defmodule Slackkit.Reminder do

  use Slackkit.Entity, [
    :id,
    :creator,
    :user,
    :text,
    :time,
    :complete_ts,
    :recurring,
  ]
  
  do_serialization

end
