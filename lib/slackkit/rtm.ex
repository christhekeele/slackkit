defmodule JSX.DecodeError do
  defexception [:reason, :string]
  
  def message(%JSX.DecodeError{reason: reason, string: string}) do
    "JSX could not decode string for reason: `:#{reason}`, string given:\n#{string}"
  end
end

defmodule Slackkit.RTM do
  
  use GenServer
  
  @url "https://slack.com/api/rtm.start?token="
  
# INTERFACE

  def start_link(name, token, manager) do
    GenServer.start_link(__MODULE__, {name, token, manager})
  end
  
# CALLBACKS

  def init({name, token, manager}) do
    case connect token do
      { :ok, json } -> IO.inspect json; {:ok, json}
      other -> other
    end
  end
  
  defp connect(token) do
    # {:ok, Connection.}
    # with  {:ok, %HTTPoison.Response{body: body} } <- HTTPoison.get(@url <> token)
    #       {:ok, json}                             <- JSX.decode(body, [{:labels, :atom}])
    #   do: {:ok, json}
    # else: {:error, reason} -> {:stop, reason}
    case HTTPoison.get(@url <> token) do
      {:ok, %HTTPoison.Response{body: body} } ->
        case JSX.decode(body, [{:labels, :atom}]) do
          {:ok, json}      -> {:ok, json}
          {:error, reason} -> {:stop, %JSX.DecodeError{reason: reason, string: body} }
        end
      {:error, reason} -> {:stop, reason}
    end
  end
  
end