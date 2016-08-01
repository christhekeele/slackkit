defmodule Slackkit.Web do
  @moduledoc """
  Main point of entry for calling the Slack Web API.

  Dynamically invokes Slack methods with `get/3` and `post/3` by passing in
  method name as a string.

  See `Slackkit.Web.Methods` for using method-named functions.
  """

  use Slackkit.Web.Endpoints

  @doc false
  def endpoints, do: @endpoints

  @methods Enum.map(@endpoints, &(&1.method))
  @doc """
  Lists known Slack methods.
  """
  def methods, do: @methods

  Slackkit.Web.Endpoint.verbs |> Enum.each(fn verb ->
    @doc """
    Uses `client` to make a `#{verb}/3` request to an API `method` using given `params`.

    For a list of available methods, see `methods/0`.
    """
    def unquote(verb)(client, method, params \\ [])

    Enum.each(@endpoints, fn(endpoint) ->
      def unquote(verb)(client, unquote(endpoint.method), params) do
        unquote(endpoint).unquote(verb)(client, params)
      end
    end)
  end)

end
