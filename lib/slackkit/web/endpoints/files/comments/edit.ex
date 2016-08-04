defmodule Slackkit.Web.Files.Comments.Edit do

  @moduledoc false

  use Slackkit.Web.Endpoint, "files.comments.edit"

  defresponse [comment: File.Comment.spec]

end
