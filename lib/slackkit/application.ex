defmodule Slackkit.Application do

  defmacro __using__(_) do
    quote location: :keep do
      use Application
      import Slackkit.Supervisor.Spec

      @before_compile Slackkit.Feature.Functions

      def start(_type, opts) do
        IO.puts "Starting #{__MODULE__} with opts: #{inspect opts}"
        specs |> Supervisor.start_link(strategy: :one_for_one, name: __MODULE__.Supervisor)
      end

      defp specs do
        [:bots, :hooks, :commands] |> Enum.flat_map( fn feature ->
          specs_for feature
        end )
      end

      defp specs_for(:bots) do
        Application.get_env(:slackkit, :users) |> List.wrap |> Enum.filter(&(&1)) |> Enum.map( fn {user, token} ->
          handlers = bots |> Keyword.get_values(user) |> List.wrap
          unless Enum.empty?(handlers) do
            bot user, token, handlers
          end
        end ) |> Enum.filter(&(&1))
      end

      # defp specs_for(:hooks) do
      #   hooks |> Enum.map(fn {name, mod} ->
      #     hook(mod, name)
      #   end )
      # end
      #
      # defp specs_for(:commands) do
      #   commands |> Enum.map(fn {name, mod} ->
      #     command(mod, name)
      #   end )
      # end

      defp specs_for(_), do: []

    end
  end

end
