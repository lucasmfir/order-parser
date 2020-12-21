defmodule OrderParser.Orders do
  import OrderParser.Helpers

  alias OrderParser.{Addresses, Customers}

  def create_order(params) do
    order =
      %{}
      |> string_field("external_code", params["id"])
      |> store_id(params)
      |> string_field("subtotal", params["total_amount"])
      |> string_field("delivery_fee", params["total_shipping"])
      |> string_field("total", params["total_amount_with_shipping"])

    customer_data = params["buyer"]
    contact_data = customer_data["phone"]

    customer =
      %{}
      |> string_field("external_code", customer_data["id"])
      |> Map.put_new(
        "name",
        Customers.customer_name(customer_data["first_name"], customer_data["last_name"])
      )
      |> Map.put_new("email", customer_data["email"])
      |> Map.put_new(
        "contact",
        Customers.customer_contact(contact_data["area_code"], contact_data["number"])
      )

    address_data = params["shipping"]["receiver_address"]

    address =
      %{}
      |> Map.put_new("country", address_data["country"]["id"])
      |> Map.put_new("state", address_data["state"]["name"])
      |> Map.put_new("city", address_data["city"]["name"])
      |> Map.put_new("district", address_data["neighborhood"]["name"])
      |> Map.put_new("street", address_data["street_name"])
      |> Map.put_new("complement", address_data["comment"])
      |> Map.put_new("number", address_data["street_number"])
      |> Map.put_new("latitude", address_data["latitude"])
      |> Map.put_new("longitude", address_data["longitude"])
      |> Map.put_new("postal_code", address_data["zip_code"])
      |> Map.put_new(
        "dt_order_create",
        Addresses.address_dt_order_create(params["shipping"]["date_created"])
      )

    # require IEx
    # IEx.pry()
  end

  defp store_id(order, params) do
    store_id = params["store_id"]

    Map.put_new(order, "store_id", store_id)
  end
end
