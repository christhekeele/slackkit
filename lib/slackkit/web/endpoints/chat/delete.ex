defmodule Slackkit.Web.Chat.Delete do

  @moduledoc false

  use Slackkit.Web.Endpoint, "chat.delete"

  defresponse [:channel, :ts]

end
