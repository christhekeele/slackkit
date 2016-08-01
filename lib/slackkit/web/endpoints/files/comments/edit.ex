defmodule Slackkit.Web.Files.Comments.Edit do

  @moduledoc false

  use Slackkit.Web.Endpoint, "files.comments.edit"

  defresponse [comment: Comment.spec]

end
