# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :chatter,
  ecto_repos: [Chatter.Repo]

config :chatter_web,
  ecto_repos: [Chatter.Repo],
  generators: [context_app: :chatter]

# Configures the endpoint
config :chatter_web, ChatterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Mww2AQQnSEwvuwyMOIzsISOw3SV1Mozk26w8iqu0pw3l1zmoz8OaRNEdy+UEr/f0",
  render_errors: [view: ChatterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChatterWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
