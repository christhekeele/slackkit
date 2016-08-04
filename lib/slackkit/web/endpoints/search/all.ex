defmodule Slackkit.Web.Search.All do

  @moduledoc false

  use Slackkit.Web.Endpoint, "search.all"

  defresponse [:query, messages: Search.Match.spec_for(Message), files: Search.Match.spec_for(File)]

end
