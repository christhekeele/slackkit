defmodule Slackkit.Web.OAuth.Access do

  @moduledoc false

  use Slackkit.Web.Endpoint, "oauth.access"

  defresponse [:access, :scope]

end
