defmodule Rtu.Clients.Deezer do
  use Rtu.Clients.Base

  defp process_url(path) do
    "http://api.deezer.com/" <> path
  end

  def search(%Rtu.Track{title: title, artist: artist}) do
    get("search", [q: "track:'#{title}' artist:'#{artist}'"])
    |> handle_response
  end
end
