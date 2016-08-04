defmodule Slackkit.Login do

  use Slackkit.Entity, [
    :user_id,
    :username,
    :date_first,
    :date_last,
    :count,
    :ip,
    :user_agent,
    :isp,
    :country,
    :region,
  ]

end
