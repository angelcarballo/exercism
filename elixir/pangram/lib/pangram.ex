defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @alphabet ~w[a b c d e f g h i j k l m n o p q r s t u v w x y z]

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence_letters = sentence |> String.downcase() |> String.codepoints()
    Enum.all?(@alphabet, fn letter -> Enum.member?(sentence_letters, letter) end)
  end
end
