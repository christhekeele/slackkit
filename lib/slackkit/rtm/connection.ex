defmodule Slackkit.RTM.Connection do
  
  @behaviour :websocket_client_handler
  
# INTERFACE

# CALLBACKS
  
  # def websocket_info(:start, _connection, client) do
  #   {:ok, client}
  # end
  # 
  # def websocket_info(message, _connection, %{slack: slack, state: state}) do
  #   {:ok, state} = handle_info(message, slack, state)
  #   {:ok, %{slack: slack, state: state}}
  # end
  # 
  # def websocket_terminate(reason, _connection, %{slack: slack, state: state}) do
  #   handle_close(reason, slack, state)
  # end
  # 
  # def websocket_handle({:ping, data}, _connection, state) do
  #   {:reply, {:pong, data}, state}
  # end
  # 
  # def websocket_handle({:text, message}, _connection, %{slack: slack, state: state}) do
  #   message = prepare_message message
  #   if Map.has_key?(message, :type) do
  #     {:ok, slack} = handle_slack(message, slack)
  #     {:ok, state} = handle_message(message, slack, state)
  #   end
  # 
  #   {:ok, %{slack: slack, state: state}}
  # end
  
end