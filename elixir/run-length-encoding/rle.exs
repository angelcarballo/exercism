defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) when is_bitstring(string), do: encode(String.codepoints(string))
  def encode([]), do: ""
  def encode(chars) when is_list(chars) do
    {part, rest} = Enum.split_while(chars, &(&1 == Enum.at(chars, 0)))
    encode_part(part) <> encode(rest)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) when is_bitstring(string) do
    Regex.scan(~r/\d*(\w| )/, string)
    |> Enum.map(&List.first/1)
    |> decode()
  end
  def decode([]), do: ""
  def decode([part | rest]) do
    decode_part(part) <> decode(rest)
  end

  defp decode_part(part) do
    case String.split_at(part, -1) do
      {"", char} -> char
      {count, char} -> String.duplicate(char, String.to_integer(count))
    end
  end

  defp encode_part([char]), do: char
  defp encode_part(chars) do
    "#{Enum.count(chars)}#{Enum.at(chars, 0)}"
  end
end
