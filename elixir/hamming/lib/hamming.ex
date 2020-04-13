defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2), do: distance(strand1, strand2, 0)

  defp distance(strand1, strand2, _count) when length(strand1) != length(strand2),
    do: {:error, "Lists must be the same length"}

  defp distance([], [], count), do: {:ok, count}
  defp distance([h | t1], [h | t2], count), do: distance(t1, t2, count)
  defp distance([h1 | t1], [h2 | t2], count), do: distance(t1, t2, count + 1)
end
