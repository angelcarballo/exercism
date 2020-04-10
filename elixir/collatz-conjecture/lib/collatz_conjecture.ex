defmodule CollatzConjecture do

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(number) when is_integer(number) and number > 0, do: do_calc(number, 0)

  defp do_calc(1, steps), do: steps
  defp do_calc(number, steps) when rem(number, 2) == 0, do: do_calc(div(number, 2), steps + 1)
  defp do_calc(number, steps) when rem(number, 2) != 0, do: do_calc(number * 3 + 1, steps + 1)
end
