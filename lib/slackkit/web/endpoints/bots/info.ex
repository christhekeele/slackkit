defmodule Slackkit.Web.Bots.Info do

  @moduledoc false

  use Slackkit.Web.Endpoint, "bots.info"

  defresponse [bot: Bot.spec]

end
