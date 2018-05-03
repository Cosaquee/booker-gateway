defmodule GatewayWeb.UserView do
  use GatewayWeb, :view

  def render("user.json", %{user: user}) do
    render_user(user)
  end


  defp render_user(user) do
    %{
      id: user["id"],
      name: user["name"],
      surname: user["surname"],
      is_admin: user["is_admin"],
      avatar_url: user["avatar_url"],
      created_at: user["created_at"]
    }
  end
end
