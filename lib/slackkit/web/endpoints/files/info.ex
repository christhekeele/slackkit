defmodule Slackkit.Web.Files.Info do

  use Slackkit.Web.Endpoint, "files.info"

  defresponse [file: File.spec, comments: [Comment.spec], paging: Pagination.spec]

end
