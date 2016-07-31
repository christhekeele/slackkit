defmodule Slackkit.Web.Bots.Info do

  use Slackkit.Web.Endpoint, "bots.info"

  defresponse [bot: %Slackkit.Bot{}]

end
