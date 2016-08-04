defmodule Slackkit.Web.Team.IntegrationLogs do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "team.integrationLogs"

  defresponse [logs: [Integration.Log.spec], paging: Pagination.spec]
  
end