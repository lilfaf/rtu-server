defmodule Rtu.Hydrator do
  use GenServer

  require Logger

  @providers [:deezer, :soundcloud, :youtube]

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def run, do: GenServer.call(__MODULE__, :work)

  def handle_call(:work, _from, state) do
    Logger.debug("Searching for metadatas")
    search_metadatas(@providers)
    { :reply, %{}, state }
  end

  defp search_metadatas([]), do: nil

  defp search_metadatas([h|tail]) do
    case Rtu.Clients.API.search(h) do
      {:ok, body} ->
        Rtu.Parser.parse(body)
      _ ->
        Logger.debug("API request failed")
    end
    search_metadatas(tail)
  end
end
