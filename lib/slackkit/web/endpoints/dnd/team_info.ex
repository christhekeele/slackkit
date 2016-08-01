defmodule Slackkit.Web.DND.TeamInfo do

  @moduledoc false

  use Slackkit.Web.Endpoint, "dnd.teamInfo"

  defresponse [:users]#[users: Slackkit.User.DND.List.spec]

end
