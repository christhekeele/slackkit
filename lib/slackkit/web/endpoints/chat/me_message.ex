defmodule Slackkit.Web.Chat.MeMessage do

  @moduledoc false

  use Slackkit.Web.Endpoint, "chat.meMessage"

  defresponse [:channel, :ts]

end
