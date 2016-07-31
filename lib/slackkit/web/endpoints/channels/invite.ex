defmodule Slackkit.Web.Channels.Invite do

  use Slackkit.Web.Endpoint, "channels.invite"

  defresponse [channel: Slackkit.Channel.spec]

end
