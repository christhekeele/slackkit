defmodule Slackkit.Web.Bots.Info do

  use Slackkit.Web.Endpoint, "bots.info"

  defresponse [bot: Bot.spec]

end
