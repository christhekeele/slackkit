defmodule Slackkit.Web.Chat.Delete do

  use Slackkit.Web.Endpoint, "chat.delete"

  defresponse [:channel, :ts]

end
