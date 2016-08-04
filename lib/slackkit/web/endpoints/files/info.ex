defmodule Slackkit.Web.Files.Info do

  @moduledoc false

  use Slackkit.Web.Endpoint, "files.info"

  defresponse [file: File.spec, comments: [File.Comment.spec], paging: Pagination.spec]

end
