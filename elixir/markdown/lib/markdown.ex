defmodule Markdown do
  # Refactor notes:
  #
  #  - remove nesting of functions, use |> operator instead
  #  - rename single-letter variables to make their content explicit
  #  - rename methods to make their intent explicit
  #  - unify string concatenation
  #  - parse bold and italics only once
  #

  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(text) do
    text
    |> String.split("\n")
    |> Enum.map(&parse_bold_and_italic/1)
    |> Enum.map_join(&parse_line/1)
    |> wrap_lists()
  end

  defp parse_line(line = "#" <> _), do: parse_header(line)
  defp parse_line(line = "*" <> _), do: parse_list(line)
  defp parse_line(line), do: parse_paragraph(line)

  defp parse_header(line) do
    {header_level, header_text} = parse_header_level(line)
    "<h#{header_level}>#{header_text}</h#{header_level}>"
  end

  defp parse_header_level(line) do
    [level | header_words] = String.split(line)
    {to_string(String.length(level)), Enum.join(header_words, " ")}
  end

  defp parse_list(line), do: "<li>#{String.trim_leading(line, "* ")}</li>"

  defp parse_paragraph(line), do: "<p>#{line}</p>"

  defp parse_bold_and_italic(line) do
    line
    |> String.split()
    |> Enum.map(&parse_bold_and_italic_opening/1)
    |> Enum.map_join(" ", &parse_bold_and_italic_closing/1)
  end

  defp parse_bold_and_italic_opening(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, "<strong>", global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp parse_bold_and_italic_closing(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  defp wrap_lists(text) do
    text
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
