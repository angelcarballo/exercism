defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> remove_punctuation
    |> separate_composed_words
    |> String.split
    |> Enum.map(&(String.at(&1, 0)))
    |> Enum.join
    |> String.upcase
  end

  defp remove_punctuation(string) do
    Regex.replace(~r/(-|,|_|;)/, string, " ")
  end

  defp separate_composed_words(string) do
    Regex.replace(~r/([a-z])([A-Z])/, string, "\\1 \\2")
  end
end
