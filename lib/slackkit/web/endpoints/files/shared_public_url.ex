defmodule Slackkit.Web.Files.SharedPublicURL do

  use Slackkit.Web.Endpoint, "files.sharedPublicURL"

  defresponse [file: File.spec, comments: [Comment.spec], paging: Pagination.spec]

end
