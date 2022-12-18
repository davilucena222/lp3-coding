defmodule Bankbb.Repo do
  use Ecto.Repo,
    otp_app: :bankbb,
    adapter: Ecto.Adapters.Postgres
end
