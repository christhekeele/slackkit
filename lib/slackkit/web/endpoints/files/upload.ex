defmodule Slackkit.Web.Files.Upload do

  use Slackkit.Web.Endpoint, "files.upload"

  defresponse [file: File.spec]

end
