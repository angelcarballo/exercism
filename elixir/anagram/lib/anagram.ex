defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) when is_list(candidates),
    do: candidates |> Enum.filter(&match(base, &1))

  def match(base, candidate) when is_binary(candidate) do
    String.downcase(base) != String.downcase(candidate) &&
      sorted_chars(base) == sorted_chars(candidate)
  end

  defp sorted_chars(word), do: word |> String.downcase() |> String.codepoints() |> Enum.sort()
end
