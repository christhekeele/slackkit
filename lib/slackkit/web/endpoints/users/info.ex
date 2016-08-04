defmodule Slackkit.Web.Users.Info do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "users.info"

  defresponse [user: User.spec]
  
end