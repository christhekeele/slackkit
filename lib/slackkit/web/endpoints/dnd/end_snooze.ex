defmodule Slackkit.Web.DND.EndSnooze do

  @moduledoc false

  use Slackkit.Web.Endpoint, "dnd.endSnooze"

  defresponse [:dnd_enabled, :next_dnd_start_ts, :next_dnd_end_ts, :snooze_enabled]

end
