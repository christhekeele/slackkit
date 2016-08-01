defmodule Slackkit.Web.Groups.List do

  @moduledoc false

  use Slackkit.Web.Endpoint, "groups.list"

  defresponse [groups: [Group.spec]]

end
