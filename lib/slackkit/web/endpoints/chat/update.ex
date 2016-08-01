defmodule Slackkit.Web.Chat.Update do

  @moduledoc false

  use Slackkit.Web.Endpoint, "chat.update"

  defresponse [:channel, :ts, :text]

end
