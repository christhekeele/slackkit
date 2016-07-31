defmodule Slackkit.Web.IM.Close do

  use Slackkit.Web.Endpoint, "im.close"

  defresponse [no_op: false, already_closed: false]

end
