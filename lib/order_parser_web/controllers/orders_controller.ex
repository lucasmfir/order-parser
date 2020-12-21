defmodule OrderParserWeb.OrderController do
  use OrderParserWeb, :controller

  action_fallback OrderParserWeb.FallbackController

  def create(conn, params) do
    with {:ok, order} <- OrderParser.Orders.create_order(params) do
      conn
      |> put_status(:created)
      |> render("order.json", order: order)
    end
  end
end
