defmodule Slackkit.Web.MPIM.Close do

  @moduledoc false

  use Slackkit.Web.Endpoint, "mpim.close"

  defresponse [no_op: false, already_closed: false]

end
