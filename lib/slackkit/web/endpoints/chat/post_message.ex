defmodule Slackkit.Web.Chat.PostMessage do

  @moduledoc false

  use Slackkit.Web.Endpoint, "chat.postMessage"

  defresponse [:channel, :ts, message: Message.spec]

end
