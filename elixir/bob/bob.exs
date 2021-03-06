defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) ->
        "Fine. Be that way!"
      question_in_capitals?(input) ->
        "Calm down, I know what I'm doing!"
      question?(input) ->
        "Sure."
      shouting?(input) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end

  defp silence?(input) do
    String.trim(input) |> String.length == 0
  end

  defp shouting?(input) do
    capitals?(input)
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end

  defp question_in_capitals?(input) do
    question?(input) && capitals?(input)
  end

  defp capitals?(input) do
    String.upcase(input) == input && String.downcase(input) != input
  end
end
