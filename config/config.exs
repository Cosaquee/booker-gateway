# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :gateway, GatewayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wvFKeg22zN0V3sqkzB8sJb/dxdzQtJx1jsHkiAKGJHp+XICRitytOk8mbILob1J0",
  render_errors: [view: GatewayWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Gateway.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
