defmodule Slackkit.User.Profile do

  # @derive [Poison.Encoder]
  defstruct [
    :avatar_hash,
    :email,
    :fields,
    :first_name,
    :last_name,
    :real_name,
    :real_name_normalized,
    :image_24,
    :image_32,
    :image_48,
    :image_72,
    :image_192,
    :image_512,
  ]

  def spec, do: %__MODULE__{}

end
