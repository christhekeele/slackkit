defmodule Slackkit.Web.Endpoint do

  @base "https://slack.com/api/"
  def base, do: @base

  @verbs [:get, :post]
  def verbs, do: @verbs

  defmacro __using__([]), do: raise ArgumentError, "must supply endpoint name"
  defmacro __using__(name) do
    quote location: :keep do

      import Slackkit.Web.Endpoint

      use Slackkit.Registry, :endpoints

      @method unquote(name)
      def method, do: @method

      defmodule Client do
        @url unquote(@base) <> unquote(name)
        def url, do: @url

        use Tesla.Builder
        plug Tesla.Middleware.BaseUrl, @url
        plug Tesla.Middleware.Headers, %{
          'Content-Type' => 'application/x-www-form-urlencoded; charset=utf8',
        }

        adapter Tesla.Adapter.Ibrowse
      end

      def get(client, params \\ []) do
        Client.get("", qs(client, params)) |> process
      end
      defp qs(client, params \\ %{}) do
        params
         |> Slackkit.Param.to_param
         |> Enum.into(%{})
         |> Map.put(:token, client.token)
      end

      def post(client, params \\ []) do
        Client.post("", encoded(client, params)) |> process
      end
      defp encoded(client, params) do
        qs(client, params)
         |> URI.encode_query
      end

      defp process(response) do
        response.body
         |> Poison.decode!(as: __MODULE__.Response.shape)
         |> verify!
      end

      defp verify!(%{ok: false, error: message}) do
        raise __MODULE__.SlackException, message
      end

      defp verify!(response = %{warnings: string}) when binary_part(string, 1, -1) do
        require Logger
        string |> String.split(",") |> Enum.each(&(Logger.warn("#Slack Web API issued warning: #{&1}")))
        response
      end

      defp verify!(response), do: response

      def shape, do: %{}
      defoverridable [shape: 0]

      defmodule SlackException do
        defexception [:message]

        def exception(info) do
          %__MODULE__{message: "Slack Web API returned an error: #{inspect info}"}
        end
      end

    end
  end

  defmacro defresponse(shape) do
    quote location: :keep do

      props = unquote(shape) |> Enum.map(fn
        ({key, value}) -> key
        (key) -> key
      end)

      # values = unquote(shape) |> Enum.filter(unquote(shape), &(is_tuple(&1)))

      def shape, do: %{unquote_splicing(Enum.filter(shape, &(is_tuple(&1))))}

      defmodule Response do

        defstruct props ++ [:ok, error: nil, warnings: ""]

        def shape do
          %__MODULE__{unquote_splicing(Enum.filter(shape, &(is_tuple(&1))))}
        end
      end

    end
  end

end
