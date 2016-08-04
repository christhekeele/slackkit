defmodule Slackkit.Web.Files.SharedPublicURL do

  @moduledoc false

  use Slackkit.Web.Endpoint, "files.sharedPublicURL"

  defresponse [file: File.spec, comments: [File.Comment.spec], paging: Pagination.spec]

end
