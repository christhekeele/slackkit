defmodule Slackkit.Web.IM.History do

  use Slackkit.Web.Endpoint, "im.history"

  defresponse [:latest, has_more: false, messages: [Slackkit.Message.spec]]

end
