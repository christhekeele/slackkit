defmodule Slackkit.IM do

  use Slackkit.Entity, [
    :id,
    :created,
    is_im: true,
    is_user_deleted: false,
  ]

  do_serialization

end
