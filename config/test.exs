import Config

config :bcrypt_elixir, :log_rounds, 1

config :hacket, Hacket.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "hacket_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :hacket, HacketWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ox/tPbqLtBABK66UYL75x0hPFNv7h2WrRGcyWAK9GfK8wCpFuv5cpi69xhOHKxY5",
  server: false

config :hacket, Hacket.Mailer, adapter: Swoosh.Adapters.Test

config :logger, level: :warn

config :phoenix, :plug_init_mode, :runtime
