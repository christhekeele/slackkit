defmodule Slackkit.Web.Users.Profile.Set do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "users.profile.set"

  defresponse [profile: User.Profile.spec]
  
end