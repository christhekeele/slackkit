defmodule Slackkit.Web.Channels.List do

  use Slackkit.Web.Endpoint, "channels.list"

  defresponse [channels: [Slackkit.Channel.spec]]

end
