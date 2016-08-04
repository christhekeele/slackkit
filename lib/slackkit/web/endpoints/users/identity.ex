defmodule Slackkit.Web.Users.Identity do

  @moduledoc false

  use Slackkit.Web.Endpoint, "users.identity"

  defresponse [user: User.spec, team: Team.spec]

end
