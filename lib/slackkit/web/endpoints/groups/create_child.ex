defmodule Slackkit.Web.Groups.CreateChild do

  @moduledoc false

  use Slackkit.Web.Endpoint, "groups.createChild"

  defresponse [group: Slackkit.Group.spec]

end
