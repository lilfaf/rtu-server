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
        title =
          Floki.find(body, "b")
          |> Floki.text
        artist =
          Floki.find(body, "p")
          |> Floki.text
        {:ok, %Track{title: title, artist: artist}}
      _ ->
        {:error, %Error{}}
    end
  end
end
