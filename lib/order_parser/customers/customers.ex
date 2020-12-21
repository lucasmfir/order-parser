defmodule OrderParser.Customers do
  import OrderParser.Helpers

  def customer_name(first_name, last_name), do: String.upcase("#{first_name} #{last_name}")

  def customer_contact(area_code, number), do: "#{parse_to_string(area_code)}#{number}"
end
