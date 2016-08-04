defmodule Slackkit.Web.Users.Profile.Get do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "users.profile.get"

  defresponse [profile: User.Profile.spec]
  
end