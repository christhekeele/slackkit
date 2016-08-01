defmodule Slackkit.Web.Groups.Info do

  @moduledoc false

  use Slackkit.Web.Endpoint, "groups.info"

  defresponse [group: Slackkit.Group.spec]

end
