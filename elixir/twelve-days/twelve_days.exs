defmodule TwelveDays do
  @gifts [
    "a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @cardinal [
    'first',
    'second',
    'third',
    'fourth',
    'fifth',
    'sixth',
    'seventh',
    'eighth',
    'ninth',
    'tenth',
    'eleventh',
    'twelfth',
  ]


  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    preface(number) <> gift_list(number)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Range.new(starting_verse, ending_verse)
    |> Enum.map(&(verse(&1)))
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp preface(number) do
    "On the #{Enum.at(@cardinal, number - 1)} day of Christmas my true love gave to me: "
  end

  defp gift_list(1) do
    gift_at(1)
  end

  defp gift_list(2) do
    "#{gift_at(2)}, and #{gift_list(1)}"
  end

  defp gift_list(number) do
    "#{gift_at(number)}, #{gift_list(number - 1)}"
  end

  defp gift_at(number) do
    Enum.at(@gifts, number - 1)
  end
end
