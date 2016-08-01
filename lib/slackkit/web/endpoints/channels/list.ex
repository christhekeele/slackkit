defmodule Slackkit.Web.Channels.List do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.list"

  defresponse [channels: [Channel.spec]]

end
