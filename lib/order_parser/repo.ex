defmodule OrderParser.Repo do
  use Ecto.Repo,
    otp_app: :order_parser,
    adapter: Ecto.Adapters.Postgres
end
