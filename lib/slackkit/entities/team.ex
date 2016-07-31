defmodule Slackkit.Team do

  use Slackkit.Entity, [
    :id,
    :name,
    :email_domain,
    :domain,
    :icon,
    :msg_edit_window_mins,
    :over_storage_limit,
    :prefs,
    :plan,
  ]

  do_serialization

end
