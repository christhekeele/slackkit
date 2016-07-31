defmodule Slackkit.Web.Groups.CreateChild do

  use Slackkit.Web.Endpoint, "groups.createChild"

  defresponse [group: Slackkit.Group.spec]

end
