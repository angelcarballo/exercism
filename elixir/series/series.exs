defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when size < 1, do: []
  def slices(s, size) do
    if String.length(s) < size do
      []
    else
      part = String.slice(s, 0, size)
      rest = String.slice(s, 1, String.length(s) - 1)
      [part] ++ slices(rest, size)
    end
  end
end
