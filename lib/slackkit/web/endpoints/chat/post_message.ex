defmodule Slackkit.Web.Chat.PostMessage do

  use Slackkit.Web.Endpoint, "chat.postMessage"

  defresponse [:channel, :ts, message: Message.spec]

end
