defmodule Slackkit.Bot.Event.Monitor do
  use GenServer
  
  def start_link(manager, handler, opts \\ []) do
    GenServer.start_link(__MODULE__, {manager, handler}, opts)
  end
  
  def start(manager, handler, opts \\ []) do
    GenServer.start(__MODULE__, {manager, handler}, opts)
  end
  
  def init({manager, handler}) do
    { :ok, do_watch(manager, handler) }
  end

  def handle_info({:gen_event_EXIT, _handler, reason}, { manager, handler }) when reason in [:normal, :shutdown] do
    { :stop, reason, { manager, handler } }
  end
  
  def handle_info({:gen_event_EXIT, _handler, _reason}, { manager, handler }) do
    { :noreply, do_watch(manager, handler) }
  end
  
  defp do_watch(manager, handler) do
    with :ok <- GenEvent.add_mon_handler(manager, handler, initial: :state),
      do: { manager, handler }
  end

end