defmodule WordCount do
  @separators [" ", "_", ",", "\n"]
  @doc """
  Count the number of words in the sentence.
  
  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> clean_sentence
    |> get_cleaned_words()
    |> Enum.filter(&(&1 != ""))
    |> Enum.frequencies()
  end

  @spec get_cleaned_words(String.t()) :: [String.t()]
  defp get_cleaned_words(sentence) do
    for word <- String.split(sentence, @separators, trim: true) do
      word
      |> String.downcase()
      |> clean_quotes()
    end
  end

  @spec clean_quotes(String.t()) :: String.t()
  def clean_quotes(string) do
    String.replace(string, ~r/^'|'$/, "")
  end

  @spec clean_sentence(String.t()) :: String.t()
  defp clean_sentence(string) do
    String.replace(string, ~r/[.:;!?ºª§@$#%"^~`&*()<>="\+\|\\{\}\[\]\\\/]+/, "")
  end
end
