defmodule Slackkit.Web.Search.Files do

  @moduledoc false

  use Slackkit.Web.Endpoint, "search.files"

  defresponse [:query, files: Search.Match.spec_for(File)]

end
