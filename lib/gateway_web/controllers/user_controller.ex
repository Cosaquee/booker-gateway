defmodule GatewayWeb.UserController do
  use GatewayWeb, :controller

  alias Gateway.Http

  action_fallback GatewayWeb.FallbackController

  def profile(conn, params) do
    response = conn
      |> Http.get("http://localhost:4000/users/" <> params["id"])

    case response do
      {:ok, user} ->
        decoded_user = Poison.decode!(user)
       conn
        |> render("user.json", %{user: decoded_user["data"]})
      {:error, _} ->
        conn
          |> put_status(500)
    end
  end

end
