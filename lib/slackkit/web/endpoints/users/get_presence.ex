defmodule Slackkit.Web.Users.GetPresence do

  @moduledoc false

  use Slackkit.Web.Endpoint, "users.getPresence"

  defresponse [:presence, :online, :auto_away, :manual_away, :connection_count, :last_activity]

end
