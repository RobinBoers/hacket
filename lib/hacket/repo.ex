defmodule Hacket.Repo do
  use Ecto.Repo,
    otp_app: :hacket,
    adapter: Ecto.Adapters.Postgres
end
