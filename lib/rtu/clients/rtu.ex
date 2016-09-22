defmodule Rtu.Clients.Rtu do
  use HTTPoison.Base
  require Logger

  @url "http://rtufm.com/script/playing.php"

  def get(), do: get!("")
  def process_url(_url), do: @url
  def process_response_body(body) do
    Logger.debug body
  end

  def playing do
    get() |> handle_response
  end

  defp handle_response(response) do
    case response do
      %{status_code: 200, body: _body} -> :ok
      _ -> :error
    end
  end
end
