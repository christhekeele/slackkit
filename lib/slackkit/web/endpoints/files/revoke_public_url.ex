defmodule Slackkit.Web.Files.RevokePublicURL do

  @moduledoc false

  use Slackkit.Web.Endpoint, "files.revokePublicURL"

  defresponse [file: File.spec]

end
