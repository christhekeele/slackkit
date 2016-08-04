defmodule Slackkit.Web.Team.Info do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "team.info"

  defresponse [team: Team.spec]
  
end