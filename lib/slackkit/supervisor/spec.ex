defmodule Slackkit.Supervisor.Spec do
  
  import Supervisor.Spec
  
  def bot(name, token, handlers) do
    supervisor Slackkit.Bot.Supervisor, [name, token, handlers]
  end
  
  def hook(mod, args, opts \\ []) do
    worker mod, args, opts
  end
  
  def command(mod, args, opts \\ []) do
    worker mod, args, opts
  end
  
end