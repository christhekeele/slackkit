defmodule Slackkit.Web.Files.Upload do

  @moduledoc false

  use Slackkit.Web.Endpoint, "files.upload"

  defresponse [file: File.spec]

end
