defmodule Slackkit.Web.Groups.Info do

  use Slackkit.Web.Endpoint, "groups.info"

  defresponse [group: Slackkit.Group.spec]

end
