defmodule Slackkit.Web.OAuth.Access do

  use Slackkit.Web.Endpoint, "oauth.access"

  defresponse [:access, :scope]

end
