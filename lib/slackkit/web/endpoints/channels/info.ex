defmodule Slackkit.Web.Channels.Info do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.info"

  defresponse [channel: Slackkit.Channel.spec]

end
