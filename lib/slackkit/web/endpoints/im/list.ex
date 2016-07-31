defmodule Slackkit.Web.IM.List do

  use Slackkit.Web.Endpoint, "im.list"

  defresponse [ims: [IM.spec]]

end
