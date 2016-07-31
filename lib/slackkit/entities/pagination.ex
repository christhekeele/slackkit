defmodule Slackkit.Pagination do

  use Slackkit.Entity, [
    :count,
    :total,
    :page,
    :pages,
  ]

end
