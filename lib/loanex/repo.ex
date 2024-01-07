defmodule Loanex.Repo do
  use Ecto.Repo,
    otp_app: :loanex,
    adapter: Ecto.Adapters.Postgres
end
