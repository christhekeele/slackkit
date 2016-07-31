defmodule Slackkit.Web.Channels.Archive do

  use Slackkit.Web.Endpoint, "channels.archive"

  defresponse [channel: %Slackkit.Channel{}]

end
