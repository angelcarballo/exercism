defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list | nil
  def convert(digits, base_a, base_b)
      when is_list(digits) and length(digits) > 0 and
             is_integer(base_a) and is_integer(base_b) and
             base_a > 1 and base_b > 0 do
    if Enum.all?(digits, &(&1 >= 0)) do
      digits
      |> to_integer(base_a)
      |> to_list(base_b)
    else
      nil
    end
  end

  def convert(_digits, _base_a, _base_b), do: nil

  defp to_integer([], _base), do: 0

  defp to_integer([digit | rest], base) do
    factor = :math.pow(base, length(rest)) |> round
    digit * factor + to_integer(rest, base)
  end

  defp to_list(0, _base), do: [0]
  defp to_list(0, _base, digits), do: digits

  defp to_list(num, base, digits \\ []) do
    to_list(div(num, base), base, [rem(num, base) | digits])
  end
end
