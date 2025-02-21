defmodule PhoenixLiveviewApp.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_liveview_app,
    adapter: Ecto.Adapters.Postgres
end
