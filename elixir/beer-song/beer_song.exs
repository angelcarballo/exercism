defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    "#{bottles_on_wall(number)}\n#{take_one(number)}\n"
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    range
    |> Enum.to_list
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
  def lyrics(), do: lyrics(99..0)

  defp bottles_on_wall(number) when number > 1 do
    "#{number} bottles of beer on the wall, #{number} bottles of beer."
  end
  defp bottles_on_wall(1) do
    "1 bottle of beer on the wall, 1 bottle of beer."
  end
  defp bottles_on_wall(0) do
    "No more bottles of beer on the wall, no more bottles of beer."
  end

  defp take_one(number) when number > 2 do
    "Take one down and pass it around, #{number-1} bottles of beer on the wall."
  end
  defp take_one(2) do
    "Take one down and pass it around, 1 bottle of beer on the wall."
  end
  defp take_one(1) do
    "Take it down and pass it around, no more bottles of beer on the wall."
  end
  defp take_one(0) do
    "Go to the store and buy some more, 99 bottles of beer on the wall."
  end
end
