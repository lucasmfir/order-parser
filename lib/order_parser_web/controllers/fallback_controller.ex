defmodule OrderParserWeb.FallbackController do
  use OrderParserWeb, :controller

  def call(conn, {:error, _reason}) do
    conn
    |> put_view(OrderParserWeb.ErrorView)
    |> render("500.json")
  end
end
