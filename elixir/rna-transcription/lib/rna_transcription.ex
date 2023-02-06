defmodule RnaTranscription do
  @dna_nucleotide_to_rna_nucleotide_map %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn char -> Map.get(@dna_nucleotide_to_rna_nucleotide_map, char) end)
  end
end
