defmodule GatewayWeb.AuthorController do
  use GatewayWeb, :controller

  alias Gateway.Http

  action_fallback GatewayWeb.FallbackController

  def new(conn, %{"author" => %{"description" => description, "name" => name, "surname" => surname}}) do
    response = conn
      |> Http.post("http://localhost:3000/author", Poison.encode!(%{name: name, surname: surname, description: description}))

    case response do
      {:ok, body} ->
        conn |> render("show.json", %{author: Poison.decode!(body)})
      {:error, error} ->
        IO.puts(error)
        conn |> put_status(500)
    end
  end

  def fetch(conn, params) do
    id = params["id"]
    case conn |> Http.get("http://localhost:3000/author/#{id}") do
      {:ok, body} ->
        conn |> render("show.json", %{author: Poison.decode!(body)})
      {:error, _} ->
        conn |> put_status(500)
    end
  end

  def search(conn, %{"query" => query}) do
    case Http.get(conn, "http://localhost:3000/author/search?" <> query) do
       {:ok, body} ->
          conn |> render("index.json", %{authors: Poison.decode!(body)})
        {:error, _} ->
          conn |> put_status(500)
    end
  end
end
