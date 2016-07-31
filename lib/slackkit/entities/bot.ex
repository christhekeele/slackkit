defmodule Slackkit.Bot do

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :deleted,
    :name,
    :icons,
  ]

  def spec, do: %__MODULE__{}

end
