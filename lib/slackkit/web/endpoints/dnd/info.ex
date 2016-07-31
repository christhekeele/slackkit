defmodule Slackkit.Web.DND.Info do

  use Slackkit.Web.Endpoint, "dnd.info"

  defresponse [:dnd_enabled, :next_dnd_start_ts, :next_dnd_end_ts, :snooze_enabled, :snooze_endtime, :snooze_remaining]

end
