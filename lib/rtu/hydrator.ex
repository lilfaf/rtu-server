defmodule Rtu.Hydrator do
  use GenServer

  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def run, do: GenServer.call(__MODULE__, :work)

  def handle_call(:work, _from, state) do
    Logger.debug("start hydrating current track...")
    case Rtu.Clients.Deezer.search(Rtu.CurrentTrack.get) do
      {:ok, body} -> IO.inspect(body)
      _ -> IO.inspect("Deezer request failed")
    end
    { :reply, %{}, state }
  end
end
