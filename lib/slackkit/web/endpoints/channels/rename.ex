defmodule Slackkit.Web.Channels.Rename do

  use Slackkit.Web.Endpoint, "channels.rename"

  defresponse [channel: Slackkit.Channel.spec]

end
