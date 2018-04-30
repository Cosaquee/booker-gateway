defmodule GatewayWeb.Router do
  use GatewayWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Gateway.AuthenticationPlug
  end

  scope "/api", GatewayWeb do
    pipe_through :api
    get "/friends", FriendController, :index
  end
end
