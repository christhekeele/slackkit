defmodule Slackkit.Bot do
  
  alias Slackkit.Icon

  use Slackkit.Entity, [
    :id,
    :deleted,
    :name,
    icons: [Icon.spec]
  ]

  do_serialization

end
