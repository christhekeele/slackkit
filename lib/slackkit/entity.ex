defmodule Slackkit.Entity do

  defmacro __using__(spec \\ []) do
    quote location: :keep do

      import unquote(__MODULE__)

      props = unquote(spec) |> Enum.map(fn
        ({key, value}) -> key
        (key) -> key
      end)

      defstruct props

      def spec, do: %__MODULE__{unquote_splicing(Enum.filter(spec, &(is_tuple(&1))))}
      defoverridable [spec: 0]

    end
  end

  defmacro do_serialization(opts \\ []) do
    quote location: :keep do

      key = unquote(opts[:key])
      if key do
        case key do
          true -> @derive Slackkit.Param
          atom -> @derive {Slackkit.Param, key: atom}
        end
      end

      encoding = unquote(opts[:encoding])
      unless encoding = false do
        case encoding do
          true -> @derive [Poison.Encoder]
          data -> @derive {Poison.Encoder, data}
        end
      end

    end
  end

end
