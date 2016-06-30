defmodule Slackkit.Bot.Event.Monitor do
  use GenServer

  def start_link(manager, handler, initial \\ []) do
    GenServer.start_link __MODULE__, {manager, handler, initial}
  end

  def start(manager, handler, initial \\ []) do
    GenServer.start __MODULE__, {manager, handler, initial}
  end

  def init({manager, handler, initial}) do
    { :ok, do_watch(manager, handler, initial) }
  end

  def handle_info({:gen_event_EXIT, handler, reason}, {manager, initial}) when reason in [:normal, :shutdown] do
    { :stop, reason, {manager, handler, initial} }
  end

  def handle_info({:gen_event_EXIT, handler, _reason}, {manager, initial}) do
    { :noreply, do_watch(manager, handler, initial) }
  end

  defp do_watch(manager, handler, initial) do
    with :ok <- GenEvent.add_mon_handler(manager, handler, initial),
      do: {manager, initial}
  end

end
