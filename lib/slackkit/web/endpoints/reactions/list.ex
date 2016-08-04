defmodule Slackkit.Web.Reactions.List do

  @moduledoc false

  use Slackkit.Web.Endpoint, "reactions.list"

  defresponse [items: [Message.spec]]

end
