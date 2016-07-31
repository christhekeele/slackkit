defmodule Slackkit.Channel.Purpose do

  # @derive [Poison.Encoder]
  defstruct [
    :creator,
    :last_set,
    :value,
  ]

  def spec, do: %__MODULE__{}

end
