defmodule Slackkit.Search.Match do
  
  alias Slackkit.Message
  alias Slackkit.File
  
  alias Slackkit.Pagination

  use Slackkit.Entity, [
    :total,
    matches: [],
    paging: Pagination.spec,
  ]
  
  def spec_for(Message) do
    spec |> Map.put(:matches, [Message.spec])
  end
  
  def spec_for(File) do
    spec |> Map.put(:matches, [File.spec])
  end

end
