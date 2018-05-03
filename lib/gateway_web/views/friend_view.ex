defmodule GatewayWeb.FriendView do
  use GatewayWeb, :view
  alias GatewayWeb.FriendView

  def render("index.json", %{friends: friends}) do
    %{data: render_many(friends, FriendView, "friend.json")}
  end

  def render("show.json", %{friend: friend}) do
    %{data: render_one(friend, FriendView, "friend.json")}
  end

  def render("friend.json", %{friend: friend}) do
    %{id: friend.id}
  end

  def render("search.json", %{users: users}) do
    %{data: users}
  end

  def render("is_friend.json", %{is_friend: is_friend}) do
    %{is_friend: is_friend["friends"]}
  end
end
