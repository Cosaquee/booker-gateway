defmodule Gateway.Http do
  def post(conn, url, content) do
    headers = headers(conn)
    case HTTPoison.post(url, content, headers) do
       {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
       {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, 404}
    end
  end

  def get(conn, url) do
    headers = headers(conn)
    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, 404}
    end
  end

  defp headers(conn) do
    token = conn.assigns.current_user["token"]
    [{"Content-Type", "application/json"}] ++ [{"Authorization", "bearer: " <> token}]
  end
end
