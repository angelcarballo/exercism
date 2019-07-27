defmodule Raindrops do
  @drops %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
  just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    @drops
    |> Enum.reduce("", fn drop, acc -> acc <> raindrop(drop, number) end)
    |> raindrops_or_number(number)
  end

  defp raindrops_or_number("", number), do: Integer.to_string(number)
  defp raindrops_or_number(raindrops, _number), do: raindrops

  defp raindrop({factor, name}, number) when factor > number, do: ""
  defp raindrop({factor, name}, number) do
    if rem(number, factor) == 0, do: name, else: ""
  end
end
