defmodule Rtu.Clients.API do
  def search(:deezer) do
    Rtu.Clients.Deezer.search(Rtu.CurrentTrack.get)
  end

  def search(:soundcloud) do
    Rtu.Clients.Soundcloud.search(Rtu.CurrentTrack.get)
  end

  def search(:youtube) do
    Rtu.Clients.Youtube.search(Rtu.CurrentTrack.get)
  end
end
