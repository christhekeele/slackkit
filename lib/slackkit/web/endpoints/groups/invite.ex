defmodule Slackkit.Web.Groups.Invite do

  use Slackkit.Web.Endpoint, "groups.invite"

  defresponse [group: Slackkit.Group.spec]

end
