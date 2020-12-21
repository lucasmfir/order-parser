defmodule OrderParser.Helpers do
  def string_field(order, field_name, value) do
    string_value = parse_to_string(value)

    Map.put_new(order, field_name, string_value)
  end

  def parse_to_string(param) when is_float(param), do: Float.to_string(param)
  def parse_to_string(param) when is_integer(param), do: Integer.to_string(param)
  def parse_to_string(param) when is_binary(param), do: param
end
