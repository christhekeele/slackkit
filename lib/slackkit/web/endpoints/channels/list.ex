defmodule Slackkit.Web.Channels.List do

  use Slackkit.Web.Endpoint, "channels.list"

  defresponse [:exclude_archived]

end
