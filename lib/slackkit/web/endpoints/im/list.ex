defmodule Slackkit.Web.IM.List do

  @moduledoc false

  use Slackkit.Web.Endpoint, "im.list"

  defresponse [ims: [IM.spec]]

end
