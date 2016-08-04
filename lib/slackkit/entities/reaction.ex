defmodule Slackkit.Reaction do

  use Slackkit.Entity, [
    :name,
    :count,
    users: [],
  ]

end
