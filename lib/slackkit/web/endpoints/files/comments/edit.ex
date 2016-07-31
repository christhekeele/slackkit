defmodule Slackkit.Web.Files.Comments.Edit do

  use Slackkit.Web.Endpoint, "files.comments.edit"

  defresponse [comment: Comment.spec]

end
