defmodule Slackkit.Web do

  use Slackkit.Web.API.Test

  use Slackkit.Web.Auth.Test
  use Slackkit.Web.Auth.Revoke

  use Slackkit.Web.Bots.Info

  use Slackkit.Web.Channels.Archive
  use Slackkit.Web.Channels.Create
  use Slackkit.Web.Channels.History
  use Slackkit.Web.Channels.Info
  use Slackkit.Web.Channels.Invite
  use Slackkit.Web.Channels.Join
  use Slackkit.Web.Channels.Kick
  use Slackkit.Web.Channels.Leave
  use Slackkit.Web.Channels.List
  use Slackkit.Web.Channels.Mark
  use Slackkit.Web.Channels.Rename
  use Slackkit.Web.Channels.SetPurpose
  use Slackkit.Web.Channels.SetTopic
  use Slackkit.Web.Channels.Unarchive

  use Slackkit.Web.Users.List

  @doc """
  Lists known Slackkit endpoints.
  """
  def endpoints, do: @endpoints

  @methods Enum.map(@endpoints, &(&1.method))
  @doc """
  Lists known Slack methods.
  """
  def methods, do: @methods

  @endpoint_methods Enum.map(@endpoints, &({&1, &1.method})) |> Enum.into(%{})
  @doc """
  Shows what Slackkit endpoints correspond to what Slack methods.
  """
  def endpoint_methods, do: @endpoint_methods

  @method_endpoints Enum.map(@endpoints, &({&1.method, &1})) |> Enum.into(%{})
  @doc """
  Shows what Slack methods correspond to what Slackkit endpoints.
  """
  def method_endpoints, do: @method_endpoints

  Slackkit.Web.Endpoint.verbs |> Enum.each(fn verb ->
    @doc """
    Uses client to make a post request to API method with params.

    For a list of available methods, see Slackkit.Web.methods/0.
    """
    def unquote(verb)(client, method, params \\ [])

    Enum.each(@endpoints, fn(endpoint) ->
      def unquote(verb)(client, unquote(endpoint.method), params) do
        unquote(endpoint).unquote(verb)(client, params)
      end
    end)
  end)

  Enum.each(@endpoints, fn(endpoint) ->
    method_name = endpoint.method
     |> String.replace(".", "_")
     |> Inflex.underscore
     |> String.to_atom

    @doc """
    Uses client to make a post request to #{endpoint.method} with params.

    For more information, see #{endpoint}.
    """
    def unquote(method_name)(client, params \\ []) do
      post(client, unquote(endpoint.method), params)
    end
  end)

end
