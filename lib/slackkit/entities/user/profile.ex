defmodule Slackkit.User.Profile do

  use Slackkit.Entity, [
    :avatar_hash,
    :email,
    :phone,
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
    fields: %{}
  ]

end
