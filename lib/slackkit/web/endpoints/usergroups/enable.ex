defmodule Slackkit.Web.UserGroups.Enable do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "usergroups.enable"

  defresponse [usergroup: User.Group.spec]
  
end