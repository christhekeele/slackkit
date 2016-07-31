defmodule Slackkit.Web.Files.List do

  use Slackkit.Web.Endpoint, "files.list"

  defresponse [files: [File.spec], paging: Pagination.spec]

end
