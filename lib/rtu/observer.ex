defmodule Rtu.Observer do
  use GenServer
  alias Rtu.Clients.Rtu

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    Rtu.playing |> schedule_work
    {:noreply, state}
  end

  defp schedule_work(), do: schedule_work(:ok)
  defp schedule_work(state) do
    Process.send_after(self(), :work, work_delay(state))
  end

  defp work_delay(:ok), do: 3000
  defp work_delay(:error), do: 10_000
  defp work_delay(state), do: work_delay(state)
end
