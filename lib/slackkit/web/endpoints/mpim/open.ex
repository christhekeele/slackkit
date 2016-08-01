defmodule Slackkit.Web.MPIM.Open do

  @moduledoc false

  use Slackkit.Web.Endpoint, "mpim.open"

  defresponse [no_op: false, already_open: false, group: MPIM.spec]

end
