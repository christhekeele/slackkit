defmodule Slackkit.Web.Groups.Create do

  @moduledoc false

  use Slackkit.Web.Endpoint, "groups.create"

  defresponse [group: Slackkit.Group.spec]

end
