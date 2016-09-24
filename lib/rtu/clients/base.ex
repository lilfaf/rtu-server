defmodule Rtu.Clients.Base do
  defmacro __using__(_) do
    quote do
      use HTTPoison.Base

      def get(path, params) do
        get(path, [], [params: params])
      end

      defp process_request_headers(headers) do
        headers ++ ["Content-Type": "application/json"]
      end

      defp process_response_body(""), do: ""
      defp process_response_body(body) do
        Poison.decode!(body, keys: :atoms)
      end

      defp handle_response(response) do
        case response do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            {:ok, body}
          {:error, %HTTPoison.Error{reason: reason}} ->
            {:error, reason}
        end
      end
    end
  end
end
