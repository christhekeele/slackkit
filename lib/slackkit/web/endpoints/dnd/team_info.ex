defmodule Slackkit.Web.DND.TeamInfo do

  use Slackkit.Web.Endpoint, "dnd.teamInfo"

  defresponse [:users]#[users: Slackkit.User.DND.List.spec]

end
