defmodule RotationalCipher do
  @lower_alphabet  'abcdefghijklmnopqrstuvwxyz'
  @upper_alphabet  'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    List.to_string(
      do_rotate(String.to_charlist(text), shift)
    )
  end

  def do_rotate([head|tail], shift) do
    [rotate_char(head, shift) | do_rotate(tail, shift)]
  end

  def do_rotate([], shift) do
    ''
  end

  def rotate_char(char, shift) do
    cond do
      Enum.member?(@lower_alphabet, char) ->
        rotate_char(char, shift, @lower_alphabet)
      Enum.member?(@upper_alphabet, char) ->
        rotate_char(char, shift, @upper_alphabet)
      # don't rotate other characters (punctuation, numbers, etc.)
      true -> char
    end
  end

  def rotate_char(char, shift, alphabet) do
    base = Enum.count(alphabet)
    position = Enum.find_index(alphabet, &(&1 == char))
    shifted_position = rem(position + shift, base)
    Enum.at(alphabet, shifted_position)
  end
end
