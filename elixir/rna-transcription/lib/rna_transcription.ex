defmodule RNATranscription do
      @dna_nucleotide_to_rna_nucleotide %{
        ?C => ?G,
        ?G => ?C,
        ?A => ?U,
        ?T => ?A,
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
        |> Enum.map(fn char ->
          Map.get(@dna_nucleotide_to_rna_nucleotide, char)
        end)
      end
    end
