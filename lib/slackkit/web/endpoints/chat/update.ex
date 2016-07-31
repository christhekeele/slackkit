defmodule Slackkit.Web.Chat.Update do

  use Slackkit.Web.Endpoint, "chat.update"

  defresponse [:channel, :ts, :text]

end
