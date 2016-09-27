defmodule Rtu.Hydrator do
  use GenServer

  require Logger

  alias Rtu.Clients.API
  alias Rtu.Parser
  alias Rtu.CurrentTrack

  @providers [:deezer, :soundcloud, :youtube]

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def run, do: GenServer.call(__MODULE__, :work)

  def handle_call(:work, _from, state) do
    Logger.debug("Searching for metadatas")
    search_metadatas(@providers)
    Logger.debug("Done searching !")
    {:reply, %{}, state}
  end

  defp search_metadatas([]), do: nil

  defp search_metadatas([h|tail]) do
    case API.search(h) do
      {:ok, body} ->
        body
        |> Parser.parse
        |> CurrentTrack.append_metadatas
      {:error, reason} ->
        Logger.error("#{h} API request failed: #{reason}")
    end
    search_metadatas(tail)
  end
end
