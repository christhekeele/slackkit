defmodule Slackkit.Web.Files.Comments.Add do

  @moduledoc false

  use Slackkit.Web.Endpoint, "files.comments.add"

  defresponse [comment: File.Comment.spec]

end
