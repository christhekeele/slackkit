# defmodule Slackkit.Supervisor do
#   
#   # defmacro __using__([]) do
#   #   raise ArgumentError, "#{__MODULE__} must specify which features to use"
#   # end
#   
#   defmacro __using__(_) do
#     quote location: :keep do
#       use Supervisor
#       import Slackkit.Supervisor.Spec
#       
#       # @features unquote(features |> List.wrap |> Enum.uniq)
#       @before_compile Slackkit.Feature.Functions
#       
#       def start_link do
#         # Needs to mount bot user tree event handlers, then thread them through bot trees
#         specs |> Supervisor.start_link(strategy: :one_for_one, name: Slackkit.Supervisor)
#       end
#       
#       defp specs, do: []
#       # defp specs do
#       #   @features |> Enum.flat_map( fn feature ->
#       #     specs_for feature
#       #   end )
#       # end
#       # 
#       # defp specs_for(:bots) do
#       #   __MODULE__.bots |> Enum.flat_map(fn {name, mod} ->
#       #     Application.get_env(:slackkit, name, []) |> Enum.map( fn config ->
#       #       bot(mod, config)
#       #     end )
#       #   end )
#       # end
#       # 
#       # defp specs_for(:hooks) do
#       #   __MODULE__.hooks |> Enum.flat_map(fn {name, mod} ->
#       #     Application.get_env(:slackkit, name, []) |> Enum.map( fn config ->
#       #       hook(mod, config)
#       #     end )
#       #   end )
#       # end
#       # 
#       # defp specs_for(:commands) do
#       #   __MODULE__.commands |> Enum.flat_map(fn {name, mod} ->
#       #     Application.get_env(:slackkit, name, []) |> Enum.map( fn config ->
#       #       command(mod, config)
#       #     end )
#       #   end )
#       # end
#       
#       # def bots, do: []
#       # def hooks, do: []
#       # def commands, do: []
#       # 
#       # defoverridable bots: 0, hooks: 0, commands: 0
#       
#     end
#   end
#   
# end
