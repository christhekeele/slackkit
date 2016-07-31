defmodule Slackkit.Web.Groups.History do

  use Slackkit.Web.Endpoint, "groups.history"

  defresponse [:latest, has_more: false, messages: [Slackkit.Message.spec]]

end
