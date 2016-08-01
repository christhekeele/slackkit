defmodule Slackkit.Web.IM.Open do

  @moduledoc false

  use Slackkit.Web.Endpoint, "im.open"

  defresponse [no_op: false, already_open: false, channel: IM.spec]

end
