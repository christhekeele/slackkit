defmodule Slackkit.Web.MPIM.History do

  use Slackkit.Web.Endpoint, "mpim.history"

  defresponse [:latest, has_more: false, messages: [Slackkit.Message.spec]]

end
