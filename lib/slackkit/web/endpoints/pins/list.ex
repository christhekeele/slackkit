defmodule Slackkit.Web.Pins.List do

  @moduledoc false

  use Slackkit.Web.Endpoint, "pins.list"

  defresponse [items: [%{}]]

end
