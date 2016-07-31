defmodule Slackkit.Web.Chat.MeMessage do

  use Slackkit.Web.Endpoint, "chat.meMessage"

  defresponse [:channel, :ts]

end
