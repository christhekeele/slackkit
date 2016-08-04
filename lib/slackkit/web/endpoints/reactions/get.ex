defmodule Slackkit.Web.Reactions.Get do

  @moduledoc false

  use Slackkit.Web.Endpoint, "reactions.get"

  defresponse [:channel, :type, messages: Message.spec]

end
