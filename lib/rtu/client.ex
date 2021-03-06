defmodule Rtu.Client do
  use HTTPoison.Base
  alias Rtu.Track

  defmodule Error do
    defexception message: "Rtu client error"
  end

  @url "http://rtufm.com/script/playing.php"

  def process_url(_url), do: @url

  def get, do: get("")

  def playing do
    get() |> handle_response
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        title  = element_text(body, "b")
        artist = element_text(body, "p")
        {:ok, %Track{title: title, artist: artist}}
      {:ok, %HTTPoison.Response{status_code: 503}} ->
        {:error, %Error{message: "Service temporarily unavailable..."}}
      _ ->
        {:error, %Error{}}
    end
  end

  defp element_text(body , tag) do
    body
    |> Floki.find(tag)
    |> Floki.text
    |> String.trim
  end
end
