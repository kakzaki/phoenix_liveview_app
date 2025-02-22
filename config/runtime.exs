import Config

if System.get_env("PHX_SERVER") do
  config :phoenix_liveview_app, PhoenixLiveviewAppWeb.Endpoint, server: true
end

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "phoenix-liveview-app.zeabur.app"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :phoenix_liveview_app, PhoenixLiveviewAppWeb.Endpoint,
    url: [host: host, port: port, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base,
    check_origin: ["https://phoenix-liveview-app.zeabur.app"],
    server: true

  config :phoenix_liveview_app, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")
end
