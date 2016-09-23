defmodule Rtu.Clients.Deezer do
  use HTTPoison.Base

  @url "http://api.deezer.com/"

  @headers [
    "Content-Type": "application/json"
  ]

  def search(%Rtu.Track{title: title, artist: artist}) do
    get("search", @headers, [params: [q: "track:'#{title}' artist:'#{artist}'"]])
    |> handle_response
  end

  defp process_url(path), do: @url <> path

  defp process_response_body(""), do: ""

  defp process_response_body(body) do
    Poison.decode!(body, keys: :atoms)
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      _ ->
        {:error, %{}}
    end
  end
end
