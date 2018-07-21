defmodule GatewayWeb.BookView do
  use GatewayWeb, :view

  def render("show.json", %{book: book}) do
    %{data: book}
  end
end
