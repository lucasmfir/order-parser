# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :order_parser,
  ecto_repos: [OrderParser.Repo]

# Configures the endpoint
config :order_parser, OrderParserWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eoKkDFspbBS4ZBmowanCzCQTL/6/17vx0Dxo7735A00WeYFqMDxkvn2//m9/2H8n",
  render_errors: [view: OrderParserWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: OrderParser.PubSub,
  live_view: [signing_salt: "HLV3V0Ps"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
