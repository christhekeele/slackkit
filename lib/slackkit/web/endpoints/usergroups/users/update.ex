defmodule Slackkit.Web.UserGroups.Users.Update do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "usergroups.users.update"

  defresponse [usergroup: User.Group.spec]
  
end