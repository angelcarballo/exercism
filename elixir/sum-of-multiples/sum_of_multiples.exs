defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, _factors) when limit < 1, do: 0
  def to(_limit, factors) when map_size(factors) == 0, do: 0
  def to(limit, factors) do
    candidates(limit)
    |> Enum.filter(&is_multiple(&1, factors))
    |> Enum.sum
  end

  defp candidates(limit), do: Enum.to_list(1..limit-1)

  defp is_multiple(_, []), do: false
  defp is_multiple(n, [h|t]), do: is_multiple(n, h) || is_multiple(n, t)
  defp is_multiple(n, factor), do: rem(n, factor) == 0
end
