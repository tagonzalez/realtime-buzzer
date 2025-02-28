# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :buzzer,
  ecto_repos: [Buzzer.Repo]

# Configures the endpoint
config :buzzer, BuzzerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qUyB/Xh/yNUTxMU0Oh7j0YqqLjx/g4vULNUhzAFq/F0XlJeXBxlZNie7W4m/oSCv",
  render_errors: [view: BuzzerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Buzzer.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "lReJurKU"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
