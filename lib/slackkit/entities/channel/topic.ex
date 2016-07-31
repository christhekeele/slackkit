defmodule Slackkit.Channel.Topic do

  # @derive [Poison.Encoder]
  defstruct [
    :creator,
    :last_set,
    :value,
  ]

  def spec, do: %__MODULE__{}

end
