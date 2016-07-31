defmodule Slackkit.Web.Channels.SetTopic do

  use Slackkit.Web.Endpoint, "channels.setTopic"

  defresponse [:topic]

end
