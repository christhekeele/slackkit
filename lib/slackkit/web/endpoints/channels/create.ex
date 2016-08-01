defmodule Slackkit.Web.Channels.Create do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.create"

  defresponse [channel: Slackkit.Channel.spec]

end
