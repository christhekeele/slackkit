defmodule Slackkit.Web.Groups.Close do

  use Slackkit.Web.Endpoint, "groups.close"

  defresponse [no_op: false, already_closed: false]

end
