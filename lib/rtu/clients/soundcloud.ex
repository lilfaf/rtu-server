defmodule Rtu.Clients.Soundcloud do
  use Rtu.Clients.Base

  defp process_url(path) do
    "https://api.soundcloud.com/" <> path
  end

  def search(%Rtu.Track{} = track) do
    get("search", search_params(track))
    |> handle_response
  end

  defp search_params(track) do
    [
      q: String.Chars.to_string(track),
      client_id: System.get_env("SOUNDCLOUD_CLIENT_ID")
    ]
  end
end
