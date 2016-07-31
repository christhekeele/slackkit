defmodule Slackkit.Web.Channels.History do

  use Slackkit.Web.Endpoint, "channels.history"

  defresponse [:latest, :has_more, messages: [%Slackkit.Message{}]]

end
