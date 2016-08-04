defmodule Slackkit.Web.UserGroups.Disable do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "usergroups.disable"

  defresponse [usergroup: User.Group.spec]
  
end