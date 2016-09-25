defmodule Rtu.TrackChannel do
  use Phoenix.Channel
  alias Rtu.CurrentTrack

  require Logger

  def join("track:*", _message, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push socket, "new_track", CurrentTrack.get
    {:noreply, socket}
  end

  def handle_in("new_track", _message, socket) do
    broadcast! socket, "new_track", CurrentTrack.get
    {:noreply, socket}
  end
end
