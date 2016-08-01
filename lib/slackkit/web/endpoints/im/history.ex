defmodule Slackkit.Web.IM.History do
  @moduledoc false

  use Slackkit.Web.Endpoint, "im.history"

  defresponse [:latest, has_more: false, messages: [Slackkit.Message.spec]]

end
