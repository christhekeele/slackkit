defmodule Slackkit.Web.Channels.SetTopic do

  @moduledoc false

  use Slackkit.Web.Endpoint, "channels.setTopic"

  defresponse [:topic]

end
