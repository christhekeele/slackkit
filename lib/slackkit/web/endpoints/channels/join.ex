defmodule Slackkit.Web.Channels.Join do

  use Slackkit.Web.Endpoint, "channels.join"

  defresponse [already_in_channel: false, channel: Slackkit.Channel.spec]

end
