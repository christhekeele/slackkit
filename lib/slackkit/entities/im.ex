defmodule Slackkit.IM do

  use Slackkit.Entity, [
    :id,
    :created,
    is_open: false,
    is_im: true,
    is_user_deleted: false,
  ]

  do_serialization

end
