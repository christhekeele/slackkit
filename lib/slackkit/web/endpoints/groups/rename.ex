defmodule Slackkit.Web.Groups.Rename do

  use Slackkit.Web.Endpoint, "groups.rename"

  defresponse [channel: Group.spec]

end
