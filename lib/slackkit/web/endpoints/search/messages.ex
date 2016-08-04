defmodule Slackkit.Web.Search.Messages do

  @moduledoc false

  use Slackkit.Web.Endpoint, "search.messages"

  defresponse [:query, messages: Search.Match.spec_for(Message)]

end
