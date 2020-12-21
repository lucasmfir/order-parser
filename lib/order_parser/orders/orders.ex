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
    # require IEx; IEx.pry()

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

    require IEx
    IEx.pry()
  end

  defp store_id(order, params) do
    store_id = params["store_id"]

    Map.put_new(order, "store_id", store_id)
  end
end

# "country": "BR",
# "state": "SP",
# "city": "Cidade de Testes",
# "district": "Bairro Fake",
# "street": "Rua de Testes Fake",
# "complement": "galpao",
# "latitude": -23.629037,
# "longitude":  -46.712689,
# "dtOrderCreate": "2019-06-27T19:59:08.251Z",
# "postalCode": "85045020",
# "number": "0",

# "shipping": {
#   "date_created": "2019-06-24T16:45:33.000-04:00",

#   "receiver_address": {
#     "street_name": "Rua Fake de Testes",
#     "street_number": "3454",
#     "zip_code": "85045020",
#     "city": {
#       "name": "Cidade de Testes"
#     },
#     "state": {
#       "name": "São Paulo"
#     },
#     "country": {
#       "id": "BR",
#       "name": "Brasil"
#     },
#     "neighborhood": {
#       "name": "Vila de Testes"
#     },
#     "latitude": -23.629037,
#     "longitude": -46.712689,
#     "receiver_phone": "41999999999"
#   }

# DateTime.to_iso8601(dt, :extended)
# "2000-02-29T23:00:07-04:00"

# DateTime.to_iso8601(dt)
# "2000-02-29T23:00:07Z"

# teste = {:ok, dt, b} = DateTime.from_iso8601
# DateTime.to_iso8601(dt)
