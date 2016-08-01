defmodule Slackkit.Web.IM.Close do
  @moduledoc false

  use Slackkit.Web.Endpoint, "im.close"

  defresponse [no_op: false, already_closed: false]

end
