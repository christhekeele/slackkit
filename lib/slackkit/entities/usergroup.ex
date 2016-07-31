defmodule Slackkit.UserGroup do

  use Slackkit.Entity, [
    :id,
    :team_id,
    :name,
    :description,
    :handle,
    :is_external,
    :date_create,
    :date_update,
    :date_delete,
    :auto_type,
    :created_by,
    :updated_by,
    :deleted_by,
    prefs: %{channels: [], groups: []},
    users: [],
    user_count: 0,
    is_mpim: false,
    is_group: false,
    is_channel: false,
    is_usergroup: true,
  ]

  do_serialization

end
