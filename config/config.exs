# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :home_appliances_store,
  ecto_repos: [HomeAppliancesStore.Repo]

# Configures the endpoint
config :home_appliances_store, HomeAppliancesStoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KLZAhDw1+Cm16lWcVUypr1O8p90qhoNpKmoU7d8Mw8In5uyFh86iq+qGcVSRzi1P",
  render_errors: [view: HomeAppliancesStoreWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: HomeAppliancesStore.PubSub,
  live_view: [signing_salt: "3C3E0mlu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
