defmodule Slackkit.Web.Endpoint do
  @moduledoc false

  @base "https://slack.com/api/"
  def base, do: @base

  @verbs [:get, :post]
  def verbs, do: @verbs

  defmacro __using__([]), do: raise ArgumentError, "must supply endpoint name"
  defmacro __using__(name) do
    quote location: :keep do

      import unquote(__MODULE__)

      alias Slackkit.Bot
      alias Slackkit.Channel
      alias Slackkit.File
      alias Slackkit.Group
      alias Slackkit.Icon
      alias Slackkit.Integration
      alias Slackkit.IM
      alias Slackkit.Login
      alias Slackkit.Message
      alias Slackkit.MPIM
      alias Slackkit.Pagination
      alias Slackkit.Purpose
      alias Slackkit.Reaction
      alias Slackkit.Reminder
      alias Slackkit.Search
      alias Slackkit.Team
      alias Slackkit.Topic
      alias Slackkit.User

      use Slackkit.Registry, :endpoints

      @method unquote(name)
      def method, do: @method

      defmodule Client do
        @moduledoc false
        @url unquote(@base) <> unquote(name)
        def url, do: @url

        use Tesla.Builder
        plug Tesla.Middleware.BaseUrl, @url
        plug Tesla.Middleware.Headers, %{
          'Content-Type' => 'application/x-www-form-urlencoded',
        }

        adapter Tesla.Adapter.Ibrowse
      end

      def get(client, params \\ []) do
        process client, Client.get("", qs(client, params))
      end
      defp qs(client, params \\ %{}) do
        params
         |> Slackkit.Param.to_param
         |> Enum.into(%{})
         |> Map.put(:token, client.token)
      end

      def post(client, params \\ []) do
        process client, Client.post("", encoded(client, params))
      end
      defp encoded(client, params) do
        qs(client, params)
         |> URI.encode_query
      end

      defp process(client, response) do
        response.body
         |> Poison.decode!(as: __MODULE__.Response.spec)
         |> Map.put(:client, client)
         |> verify!
      end

      defp verify!(%{ok: false, error: message}) do
        raise __MODULE__.SlackException, message
      end

      defp verify!(response = %{warning: ""}) do
        response
      end

      defp verify!(response = %{warning: string}) do
        require Logger
        string |> String.split(",") |> Enum.each(&(Logger.warn("Slack Web API issued warning: #{&1}")))
        response
      end

      def spec, do: %{}
      defoverridable [spec: 0]

      defmodule SlackException do
        @moduledoc false
        defexception [:message]

        def exception(info) do
          %__MODULE__{message: "Slack Web API returned an error: #{inspect info}"}
        end
      end

    end
  end

  defmacro defresponse(spec \\ []) do
    quote location: :keep do

      props = unquote(spec) |> Enum.map(fn
        ({key, value}) -> key
        (key) -> key
      end)

      def spec, do: %{unquote_splicing(Enum.filter(spec, &(is_tuple(&1))))}

      defmodule Response do
        @moduledoc false

        defstruct props ++ [:client, :ok, error: nil, warning: ""]

        def spec do
          %__MODULE__{unquote_splicing(Enum.filter(spec, &(is_tuple(&1))))}
        end
      end

    end
  end

end
