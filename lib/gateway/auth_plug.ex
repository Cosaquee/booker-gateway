require IEx
defmodule Gateway.AuthenticationPlug do

  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    IEx.pry

    conn
  end
end
