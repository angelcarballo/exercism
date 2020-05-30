defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when is_integer(count) and count > 0, do: do_nth(count, [], 2)

  defp do_nth(count, [prime | _previous] = primes, _) when length(primes) == count,
    do: prime

  defp do_nth(count, primes, candidate) do
    if prime?(candidate) do
      do_nth(count, [candidate | primes], candidate + 1)
    else
      do_nth(count, primes, candidate + 1)
    end
  end

  defp prime?(1), do: true
  defp prime?(2), do: true

  defp prime?(number) when is_integer(number) and number > 2 do
    2..(number - 1)
    |> Enum.all?(fn x -> rem(number, x) != 0 end)
  end
end
