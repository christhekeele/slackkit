defmodule Slackkit.Web.Channels.SetPurpose do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.setPurpose"

  defresponse [:purpose]

end
