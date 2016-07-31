defmodule Slackkit.Web.Users.List do

  use Slackkit.Web.Endpoint, "users.list"

  defresponse [members: [Slackkit.User.spec]]

end
