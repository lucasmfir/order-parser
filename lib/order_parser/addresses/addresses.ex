defmodule OrderParser.Addresses do
  def address_dt_order_create(date) do
    date
    |> DateTime.from_iso8601()
    |> elem(1)
    |> DateTime.to_iso8601()
  end
end
