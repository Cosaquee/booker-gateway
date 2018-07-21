defmodule GatewayWeb.BookController do
  use GatewayWeb, :controller

  alias Gateway.Http

  action_fallback GatewayWeb.FallbackController

  def new(conn, %{"book" => book_params }) do
    response = conn
      |> Http.post("http://localhost:3000/book", Poison.encode!(%{title: book_params["description"], author_id: book_params["author_id"], description: book_params["description"], isbn: book_params["isbn"]}))

    case response do
      {:ok, body} ->
        conn |> render("show.json", %{book: Poison.decode!(body)})
      {:error, error} ->
        IO.puts(error)
        conn |> put_status(500)
    end
  end
end
