defmodule RNATranscription do
  @dna_to_rna_pairs %{
    'G' => 'C',
    'C' => 'G',
    'T' => 'A',
    'A' => 'U'
  }

  @doc """

  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.reduce([], fn nucleotide, list ->
      list ++ Map.fetch!(@dna_to_rna_pairs, [nucleotide])
    end)
  end
end