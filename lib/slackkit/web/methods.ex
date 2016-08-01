defmodule Slackkit.Web.Methods do
  @moduledoc """
  Hard-coded, importable convenience functions for calling Slack Web API methods.

  Uses `Slackkit.Web.post/3` for security and freshness by default.
  If you want these calls to be in the clear and cachable, use `Slackkit.Web.get/3`.
  """

  Slackkit.Web.endpoints |> Enum.each(fn(endpoint) ->
    method_name = endpoint.method
     |> String.replace(".", "_")
     |> Inflex.underscore
     |> String.to_atom

    @doc """
    Uses `client` to make a post request to `"#{endpoint.method}"` with given `params`.

    Uses `#{endpoint |> Atom.to_string |> String.replace_prefix("Elixir.", "")}` under
    the covers.
    """
    def unquote(method_name)(client, params \\ []) do
      Slackkit.Web.post(client, unquote(endpoint.method), params)
    end
  end)

end
