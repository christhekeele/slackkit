defmodule Slackkit.Team do
  
  alias Slackkit.Icon

  use Slackkit.Entity, [
    :id,
    :name,
    :email_domain,
    :domain,
    :msg_edit_window_mins,
    :over_storage_limit,
    :prefs,
    :plan,
    icon: Icon.spec,
  ]

  do_serialization

end
