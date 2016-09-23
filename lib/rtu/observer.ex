defmodule Rtu.Observer do
  use GenServer

  require Logger

  alias Rtu.Client
  alias Rtu.CurrentTrack
  alias Rtu.Track
  alias Rtu.Hydrator

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work
    {:ok, state}
  end

  def handle_info(:work, state) do
    Client.playing |> schedule_work
    {:noreply, state}
  end

  defp schedule_work, do: schedule_work(:ok)

  defp schedule_work({:error, %Client.Error{message: message}}) do
    Logger.error(message)
    schedule_work(:error)
  end

  defp schedule_work({:ok, %Track{} = track}) do
    unless CurrentTrack.get == track do
      Logger.debug(track)
      CurrentTrack.set(track)
      Hydrator.run
    end
    schedule_work
  end

  defp schedule_work(state) do
    Process.send_after(self(), :work, work_delay(state))
  end

  defp work_delay(:ok), do: 3000
  defp work_delay(:error), do: 10_000
  defp work_delay(state), do: work_delay(state)
end
