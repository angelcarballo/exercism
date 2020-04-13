defmodule Say do
  @parts %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or number > 999_999_999_999,
    do: {:error, "number is out of range"}

  def in_english(0), do: {:ok, "zero"}
  def in_english(number), do: {:ok, do_say(number) |> String.trim()}

  defp do_say(0), do: ""
  defp do_say(number) when number < 20, do: Map.get(@parts, number)
  defp do_say(number) when number < 100 and rem(number, 10) == 0, do: Map.get(@parts, number)

  defp do_say(number) when number < 100,
    do: do_say(div(number, 10) * 10) <> "-" <> do_say(rem(number, 10))

  defp do_say(number) when number < 1_000,
    do: do_say(div(number, 100)) <> " hundred " <> do_say(rem(number, 100))

  defp do_say(number) when number < 1_000_000,
    do: do_say(div(number, 1_000)) <> " thousand " <> do_say(rem(number, 1_000))

  defp do_say(number) when number < 1_000_000_000,
    do: do_say(div(number, 1_000_000)) <> " million " <> do_say(rem(number, 1_000_000))

  defp do_say(number) when number < 1_000_000_000,
    do: do_say(div(number, 1_000_000)) <> " million " <> do_say(rem(number, 1_000_000))

  defp do_say(number) when number < 999_999_999_999,
    do: do_say(div(number, 1_000_000_000)) <> " billion " <> do_say(rem(number, 1_000_000_000))
end
