defmodule Slackkit.Web.UserGroups.List do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "usergroups.list"

  defresponse [usergroups: [User.Group.spec]]
  
end