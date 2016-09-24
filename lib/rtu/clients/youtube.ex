defmodule Rtu.Clients.Youtube do
  use Rtu.Clients.Base

  def process_url(path) do
    "https://www.googleapis.com/youtube/v3/" <> path
  end

  def search(%Rtu.Track{} = track) do
    get("search", search_params(track))
    |> handle_response
  end

  def search_params(track) do
    [
      q: String.Chars.to_string(track),
      key: System.get_env("YOUTUBE_API_KEY"),
      part: "snippet",
      type: "video"
    ]
  end
end
