defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    letters = letters_in_sentence(sentence)
    unique_letters = Enum.uniq(letters)
    Enum.count(letters) == Enum.count(unique_letters)
  end

  defp letters_in_sentence(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[^a-z]/, "")
    |> String.codepoints()
  end
end
