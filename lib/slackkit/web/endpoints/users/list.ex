defmodule Slackkit.Web.Users.List do

  @moduledoc false

  use Slackkit.Web.Endpoint, "users.list"

  defresponse [members: [User.spec]]

end
