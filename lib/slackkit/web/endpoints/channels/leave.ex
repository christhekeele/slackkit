defmodule Slackkit.Web.Channels.Leave do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.leave"

  defresponse [not_in_channel: false]

end
