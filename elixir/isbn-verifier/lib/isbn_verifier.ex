defmodule IsbnVerifier do
  @isbn_format ~r/\A\d{9}(\d|X)\z/

  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) when is_binary(isbn) do
    clean_isbn = String.replace(isbn, "-", "")
    Regex.match?(@isbn_format, clean_isbn) && zero_checksum?(clean_isbn)
  end

  defp zero_checksum?(isbn) when is_binary(isbn), do: String.codepoints(isbn) |> zero_checksum?
  defp zero_checksum?(values) when is_list(values) do
    checksum =
      values
      |> Enum.map(&char_value/1)
      |> Enum.zip(10..1)
      |> Enum.reduce(0, fn {value, factor}, sum ->
        sum + (value * factor)
      end)
      |> rem(11)
    checksum == 0
  end

  defp char_value("X"), do: 10
  defp char_value(number), do: String.to_integer(number)
end
