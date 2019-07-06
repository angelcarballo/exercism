defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split(~r/(:|!|&|@|\$|%|\^|,|_| )/, trim: true)
    |> Enum.reduce(%{}, &add_occurrence/2)
  end

  defp add_occurrence(word, list) do
    Map.update(list, word, 1, &((&1 + 1)))
  end
end
