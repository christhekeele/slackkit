defmodule Slackkit.Web.Client do

  defstruct [:token]

  def new, do: %__MODULE__{token: "xoxp-44648740229-44654344737-64770126211-85b809f823"}
  def new(token), do: %__MODULE__{token: token}

end
