defmodule Slackkit.Web.Channels.History do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.history"

  defresponse [:latest, has_more: false, messages: [Slackkit.Message.spec]]

end
