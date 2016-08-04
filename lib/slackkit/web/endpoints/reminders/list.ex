defmodule Slackkit.Web.Reminders.List do

  @moduledoc false

  use Slackkit.Web.Endpoint, "reminders.list"

  defresponse [reminders: [Reminder.spec]]

end
