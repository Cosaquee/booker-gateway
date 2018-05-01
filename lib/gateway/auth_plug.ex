require IEx
defmodule Gateway.AuthenticationPlug do

  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    token = conn |> get_req_header("authorization" ) |> List.first |> String.split(" ") |> List.last

    response = HTTPoison.post("http://localhost:4000/auth", Poison.encode!(%{token: token }), [{"Content-Type", "application/json"}])
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        user = Poison.decode!(body)

        conn
          |> assign(:current_user, user)
          |> put_status(200)
       {:ok, %HTTPoison.Response{status_code: 404}} ->
        conn
          |> put_status(400)
    end
  end
end
