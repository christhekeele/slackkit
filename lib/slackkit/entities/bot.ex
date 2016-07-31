defmodule Slackkit.Bot do

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :deleted,
    :name,
    :icons,
  ]

end
