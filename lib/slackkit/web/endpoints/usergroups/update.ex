defmodule Slackkit.Web.UserGroups.Update do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "usergroups.update"

  defresponse [usergroup: User.Group.spec]
  
end