defmodule Slackkit.User do

  alias Slackkit.User.Profile

  use Slackkit.Entity, [
    :id,
    :name,
    :color,
    :deleted,
    :name,
    :real_name,
    :tz,
    :tz_label,
    :tz_offset,
    :presence,
    :is_admin,
    :is_owner,
    :is_restricted,
    :is_ultra_restricted,
    :has_2fa,
    :two_factor_type,
    :has_files,
    profile: Profile.spec,
  ]

  do_serialization

end
