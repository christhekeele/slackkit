defmodule Slackkit.Web.Channels.Join do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.join"

  defresponse [already_in_channel: false, channel: Slackkit.Channel.spec]

end
