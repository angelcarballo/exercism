defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |>letters_in_sentence()
    |> Enum.frequencies()
    |> Enum.all?(fn ({_letter, frequency}) -> frequency == 1  end)
  end

  defp letters_in_sentence(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[^a-z]/, "")
    |> String.codepoints()
  end
end
