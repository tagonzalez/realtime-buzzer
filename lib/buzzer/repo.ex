defmodule Buzzer.Repo do
  use Ecto.Repo,
    otp_app: :buzzer,
    adapter: Ecto.Adapters.Postgres
end
