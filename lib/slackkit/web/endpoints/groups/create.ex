defmodule Slackkit.Web.Groups.Create do

  use Slackkit.Web.Endpoint, "groups.create"

  defresponse [group: Slackkit.Group.spec]

end
