defmodule Slackkit.Web.MPIM.History do

  @moduledoc false

  use Slackkit.Web.Endpoint, "mpim.history"

  defresponse [:latest, has_more: false, messages: [Slackkit.Message.spec]]

end
