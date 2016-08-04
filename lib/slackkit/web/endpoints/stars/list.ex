defmodule Slackkit.Web.Stars.List do

  @moduledoc false

  use Slackkit.Web.Endpoint, "stars.list"

  defresponse [items: [%{}], paging: Pagination.spec]

end
