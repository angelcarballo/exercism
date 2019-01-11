defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.replace(~r/(:|!|&|@|\$|%|\^|,|_)/, sentence, " ")
    |> String.downcase
    |> String.split
    |> Enum.reduce(%{}, &add_word/2)
  end

  defp add_word(word, list) do
    new_count = Map.get(list, word, 0) + 1
    Map.put(list, word, new_count)
  end
end
