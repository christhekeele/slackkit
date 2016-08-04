defmodule Slackkit.Web.Reminders.Add do

  @moduledoc false

  use Slackkit.Web.Endpoint, "reminders.add"

  defresponse [reminder: Reminder.spec]

end
