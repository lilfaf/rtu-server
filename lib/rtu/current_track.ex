defmodule Rtu.CurrentTrack do
  alias Rtu.Track

  def start_link do
    Agent.start_link(fn -> %Track{} end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, fn(track) -> track end)
  end

  def set(track) do
    Agent.update(__MODULE__, fn(_track) -> track end)
  end

  def append_metadatas(nil), do: nil

  def append_metadatas(metadatas) do
    Agent.update(__MODULE__, fn(track) ->
      %Track{track | metadatas: track.metadatas ++ [metadatas]}
    end)
  end
end
