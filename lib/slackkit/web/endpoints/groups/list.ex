defmodule Slackkit.Web.Groups.List do

  use Slackkit.Web.Endpoint, "groups.list"

  defresponse [groups: [Group.spec]]

end
