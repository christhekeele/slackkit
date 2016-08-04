defmodule Slackkit.Web.UserGroups.Create do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "usergroups.create"

  defresponse [usergroup: User.Group.spec]
  
end