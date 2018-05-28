defmodule GatewayWeb.FriendController do
  use GatewayWeb, :controller

  alias Gateway.Http

  action_fallback GatewayWeb.FallbackController

  def search(conn, %{"query" => query}) do
    query = Poison.encode!(%{"query" => query})

    response = conn |>
      Http.post("http://localhost:4000/friends/search", query)
    case response do
      {:ok, body} ->
        render(conn, "search.json", users: Poison.decode!(body))
      {:error, _} ->
        conn |> put_status(500)
    end
  end

  def is_friend(conn, params) do
    user_id = conn.assigns.current_user["user"]["id"]
    friend_id = params["id"]
    url = "http://localhost:3000/check-friendship/" <> Integer.to_string(user_id) <> "/" <> friend_id

    case conn |> Http.get(url) do
      {:ok, body} ->
        render(conn, "is_friend.json", is_friend: Poison.decode!(body))
      {:error, result_code} ->
        conn |> put_status(result_code)
    end
  end

  def add_friend(conn, %{"friend_id" => friend_id}) do
    user_id = conn.assigns.current_user["user"]["id"]
    case conn |> Http.post("http://localhost:3000/friends", Poison.encode!(%{current_user_id: user_id, friend_id: friend_id})) do
       {:ok, _} ->
        conn |> render("is_friend.json", is_friend: %{friends: true})
      {:error, status_code} ->
        conn |> put_status(status_code)
    end
  end

  def index(conn, _) do
    user_id = conn.assigns.current_user["user"]["id"]

    with {:ok, body} <- conn |> Http.get("http://localhost:3000/friends/" <> Integer.to_string(user_id)),
         {:ok, users} <- conn |> Http.get("http://localhost:4000/friends?ids=" <> body)
    do
      render(conn, "search.json", users: Poison.decode!(users))
    end
  end
end
