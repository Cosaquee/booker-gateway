require IEx
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

  # def index(conn, _params) do
    # conn
    # friends = Friends.list_friends()
    # render(conn, "index.json", friends: friends)
  # end

  # def create(conn, %{"friend" => friend_params}) do
    # with {:ok, %Friend{} = friend} <- Friends.create_friend(friend_params) do
      # conn
      # |> put_status(:created)
      # |> put_resp_header("location", friend_path(conn, :show, friend))
      # |> render("show.json", friend: friend)
    # end
  # end

  # def show(conn, %{"id" => id}) do
    # friend = Friends.get_friend!(id)
    # render(conn, "show.json", friend: friend)
  # end

  # def update(conn, %{"id" => id, "friend" => friend_params}) do
    # friend = Friends.get_friend!(id)

    # with {:ok, %Friend{} = friend} <- Friends.update_friend(friend, friend_params) do
      # render(conn, "show.json", friend: friend)
    # end
  # end

  # def delete(conn, %{"id" => id}) do
    # friend = Friends.get_friend!(id)
    # with {:ok, %Friend{}} <- Friends.delete_friend(friend) do
      # send_resp(conn, :no_content, "")
    # end
  # end
end
