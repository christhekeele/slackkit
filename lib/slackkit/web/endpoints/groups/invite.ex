defmodule Slackkit.Web.Groups.Invite do

  @moduledoc false

  use Slackkit.Web.Endpoint, "groups.invite"

  defresponse [group: Slackkit.Group.spec]

end
