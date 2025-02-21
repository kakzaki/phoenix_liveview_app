defmodule PhoenixLiveviewApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixLiveviewAppWeb.Telemetry,
      PhoenixLiveviewApp.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_liveview_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixLiveviewApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixLiveviewApp.Finch},
      # Start a worker by calling: PhoenixLiveviewApp.Worker.start_link(arg)
      # {PhoenixLiveviewApp.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixLiveviewAppWeb.Endpoint,

      # Tambahkan Store di sini, tanpa komentar #
      {PhoenixLiveviewApp.Books.Store, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixLiveviewApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixLiveviewAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
