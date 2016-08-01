defmodule Slackkit.Web.DND.SetSnooze do

  @moduledoc false

  use Slackkit.Web.Endpoint, "dnd.setSnooze"

  defresponse [:snooze_enabled, :snooze_endtime, :snooze_remaining]

end
