defmodule ProteinTranslation do
  @codon_size 3
  @stop "STOP"
  @invalid_codon "invalid codon"
  @invalid_RNA "invalid RNA"
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    chunks = String.length(rna) |> div(@codon_size)
    steps = 0..(chunks - 1)

    codons =
      Enum.map(steps, fn step -> String.slice(rna, step * @codon_size, @codon_size) end)
      |> Enum.map(&of_codon/1)

    invalid_codons? = Enum.any?(codons, fn {_, c} -> c == @invalid_codon end)

    if invalid_codons? do
      {:error, @invalid_RNA}
    else
      {:ok, filter_codons!(codons)}
    end
  end

  @spec filter_codons!(list({atom, String.t()})) :: list(String.t())
  defp filter_codons!([]) do
    []
  end

  defp filter_codons!([head | tail]) do
    case head do
      {:ok, @stop} -> []
      {:error, _} -> []
      {:ok, protein} -> [protein] ++ filter_codons!(tail)
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
    case codon do
      "UGU" -> {:ok, "Cysteine"}
      "UGC" -> {:ok, "Cysteine"}
      "UUA" -> {:ok, "Leucine"}
      "UUG" -> {:ok, "Leucine"}
      "AUG" -> {:ok, "Methionine"}
      "UUU" -> {:ok, "Phenylalanine"}
      "UUC" -> {:ok, "Phenylalanine"}
      "UCU" -> {:ok, "Serine"}
      "UCC" -> {:ok, "Serine"}
      "UCA" -> {:ok, "Serine"}
      "UCG" -> {:ok, "Serine"}
      "UGG" -> {:ok, "Tryptophan"}
      "UAU" -> {:ok, "Tyrosine"}
      "UAC" -> {:ok, "Tyrosine"}
      "UAA" -> {:ok, "STOP"}
      "UAG" -> {:ok, "STOP"}
      "UGA" -> {:ok, "STOP"}
      _ -> {:error, "invalid codon"}
    end
  end
end
