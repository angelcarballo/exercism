defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @modifiers %{ 0b10000 => :reverse }
  @steps %{
    0b1 => "wink",
    0b10 => "double blink",
    0b100 => "close your eyes",
    0b1000 => "jump"
  }

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Enum.reduce(
      requested_modifiers(code),
      requested_commands(code),
      &apply_modifier(&1, &2)
    )
  end

  def requested_modifiers(code) do
    Map.keys(@modifiers)
    |> Enum.filter(&with_mask(&1, code))
    |> (&Map.take(@modifiers, &1)).()
    |> Map.values
  end

  def requested_commands(code) do
    Map.keys(@steps)
    |> Enum.filter(&with_mask(&1, code))
    |> (&Map.take(@steps, &1)).()
    |> Map.values
  end

  def apply_modifier(modifier, handshake) do
    case modifier do
      :reverse -> Enum.reverse(handshake)
      _ -> raise(ArgumentError, message: "unknown modifier '#{modifier}'")
    end
  end

  def with_mask(mask, code) do
    (mask &&& code) == mask
  end
end
