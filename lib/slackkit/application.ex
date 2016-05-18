defmodule Slackkit.Application do
  
  # defmacro __using__([]) do
  #   raise ArgumentError, "#{__MODULE__} must specify which features to use"
  # end
  
  defmacro __using__(_) do
    quote location: :keep do
      use Application
      import Slackkit.Supervisor.Spec
      
      @before_compile Slackkit.Feature.Functions
      
      def start(_type, opts) do
        IO.puts "Starting #{__MODULE__} with opts: #{inspect opts}"
        # IO.inspect specs
        specs_for(:bots) |> Supervisor.start_link(strategy: :one_for_one, name: __MODULE__.Supervisor)
      end
      
      # defp specs, do: []
      defp specs do
        # IO.inspect features
        features |> Enum.flat_map( fn feature ->
          specs_for feature
        end )
      end
      
      defp specs_for(:bots) do
        Application.get_env(:slackkit, :bot_users) |> Enum.map( fn {name, token} ->
          bot name, token, Keyword.get_values(bots, name)
        end )
        # bots |> Enum.map(fn {name, mod} ->
        #   bot(mod, name)
        # end )
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
