defmodule Slackkit.Web.Team.BillableInfo do
  
  @moduledoc false

  use Slackkit.Web.Endpoint, "team.billableInfo"

  defresponse [billable_info: %{}]
  
end