defmodule Slackkit.User do

  alias Slackkit.User.Profile

  @derive [Poison.Encoder]
  defstruct [
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
    :profile,
    :is_admin,
    :is_owner,
    :is_restricted,
    :is_ultra_restricted,
    :has_2fa,
    :two_factor_type,
    :has_files,
  ]

  def spec, do: %__MODULE__{profile: Profile.spec}

end
