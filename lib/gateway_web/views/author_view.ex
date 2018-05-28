defmodule GatewayWeb.AuthorView do
  use GatewayWeb, :view

  def render("show.json", %{author: author}) do
    %{data: %{name: author["name"], surname: author["surname"], id: author["id"], description: author["description"], avatar_url: author["avatar_url"] }}
  end

  def render("index.json", %{authors: authors}) do
    %{data: %{authors: authors}}
  end
end
