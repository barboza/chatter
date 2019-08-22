use Mix.Config

# Configure your database
config :chatter, Chatter.Repo,
  username: "postgres",
  password: "postgres",
  database: "chatter_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

signing_salt =
  System.get_env("LIVE_VIEW_SALT") ||
    raise """
    environment variabme LIVE_VIEW_SALT is missing!
    You can set it using export LIVE_VIEW_SALT="$(mix phx.gen.secret)"
    """

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chatter_web, ChatterWeb.Endpoint,
  http: [port: 4002],
  server: false,
  live_view: [
    signing_salt: signing_salt
  ]

# Print only warnings and errors during test
config :logger, level: :warn
