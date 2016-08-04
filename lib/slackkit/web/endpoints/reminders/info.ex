defmodule Slackkit.Web.Reminders.Info do

  @moduledoc false

  use Slackkit.Web.Endpoint, "reminders.info"

  defresponse [reminder: Reminder.spec]

end
