defmodule Slackkit.Feature do

  defmodule Functions do

    @features [:bots, :commands, :hooks]

    defmacro __before_compile__(_) do
      quote location: :keep, bind_quoted: [features: @features] do
        features |> Enum.map( fn feature ->
          def unquote(feature)(), do: []
          defoverridable [{feature, 0}]
        end )
      end
    end

  end

end
