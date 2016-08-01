defmodule Slackkit.Web.Channels.Rename do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.rename"

  defresponse [channel: Channel.spec]

end
