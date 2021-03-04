# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :myApi,
  ecto_repos: [MyApi.Repo]

# Configures the endpoint
config :myApi, MyApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VvHh8Ym/D2+5McdkNO1ejqgc0zWgAvkqsJhDziR1N0VGm/8sW8ss5x1Dr0l9z1cj",
  render_errors: [view: MyApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MyApi.PubSub,
  live_view: [signing_salt: "UsHBaZhi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config
config :myApi, MyApi.Guardian,
  issuer: "myApi",
  secret_key: "5qU3kUUe3Hak917wGWdlym7uI253NrnhDiYKIyd38QMOX3YZPpkqfEgkt5QhZ1iN"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
