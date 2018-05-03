defmodule GatewayWeb.Router do
  use GatewayWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Gateway.AuthenticationPlug
  end

  scope "/api", GatewayWeb do
    pipe_through [:api]

    scope "/friends" do
      post "/", FriendController, :add_friend
      get "/", FriendController, :index
      post "/search", FriendController, :search
      get "/check-friendship/:id", FriendController, :is_friend
    end

    scope "/users" do
      get "/:id", UserController, :profile
    end
  end
end
