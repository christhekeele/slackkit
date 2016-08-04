defmodule Slackkit.Web.Team.Profile.Get do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "team.profile.get"

  defresponse [profile: Team.Profile.spec]
  
end