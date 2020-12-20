defmodule OrderParser.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      OrderParser.Repo,
      # Start the Telemetry supervisor
      OrderParserWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: OrderParser.PubSub},
      # Start the Endpoint (http/https)
      OrderParserWeb.Endpoint
      # Start a worker by calling: OrderParser.Worker.start_link(arg)
      # {OrderParser.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OrderParser.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    OrderParserWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
