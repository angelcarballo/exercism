defmodule ProteinTranslation do
  @codon_size 3
  @protein_codons %{
    "Methionine"    => ["AUG"],
    "Phenylalanine" => ["UUU","UUC"],
    "Leucine"       => ["UUA","UUG"],
    "Serine"        => ["UCU","UCC","UCA","UCG"],
    "Tyrosine"      => ["UAU","UAC"],
    "Cysteine"      => ["UGU","UGC"],
    "Tryptophan"    => ["UGG"],
    "STOP"          => ["UAA", "UAG", "UGA"]
  }
  @codon_protein_map Enum.into(
    Enum.flat_map(
      @protein_codons,
      fn {protein, codons} -> Enum.map(codons, &({&1, protein})) end
    ),
    %{}
  )

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    proteins =
      String.to_charlist(rna)
      |> Enum.chunk_every(@codon_size)
      |> Enum.map(&List.to_string/1)
      |> Enum.map(&of_codon/1)

    if Keyword.has_key?(proteins, :error) do
      {:error, "invalid RNA"}
    else
      Keyword.values(proteins)
      |> Enum.split_while(&(&1 == "STOP"))
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    Map.fetch(@codon_protein_map, codon)
  end
end
