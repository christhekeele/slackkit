defmodule Slackkit.Web.Channels.Create do

  use Slackkit.Web.Endpoint, "channels.create"

  defresponse [channel: %Slackkit.Channel{}]

end
