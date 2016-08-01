defmodule Slackkit.Web.Channels.Invite do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.invite"

  defresponse [channel: Slackkit.Channel.spec]

end
