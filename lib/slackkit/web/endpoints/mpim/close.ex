defmodule Slackkit.Web.MPIM.Close do

  use Slackkit.Web.Endpoint, "mpim.close"

  defresponse [no_op: false, already_closed: false]

end
