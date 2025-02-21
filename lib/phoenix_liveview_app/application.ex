defmodule PhoenixLiveviewApp.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixLiveviewAppWeb.Telemetry,
      {Phoenix.PubSub, name: PhoenixLiveviewApp.PubSub},
      # Start to serve requests
      PhoenixLiveviewAppWeb.Endpoint,
      # Store for in-memory book management
      {PhoenixLiveviewApp.Books.Store, []}
    ]

    opts = [strategy: :one_for_one, name: PhoenixLiveviewApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    PhoenixLiveviewAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
