defmodule Slackkit.Web.Team.AccessLogs do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "team.accessLogs"

  defresponse [logins: [Login.spec], paging: Pagination.spec]
  
end