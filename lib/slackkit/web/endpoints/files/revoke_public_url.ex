defmodule Slackkit.Web.Files.RevokePublicURL do

  use Slackkit.Web.Endpoint, "files.revokePublicURL"

  defresponse [file: File.spec]

end
