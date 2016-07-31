defmodule Slackkit.Web.Channels.Info do

  use Slackkit.Web.Endpoint, "channels.info"

  defresponse [channel: %Slackkit.Channel{}]

end
