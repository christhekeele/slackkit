defmodule Slackkit.Web.Groups.Rename do

  @moduledoc false

  use Slackkit.Web.Endpoint, "groups.rename"

  defresponse [channel: Group.spec]

end
