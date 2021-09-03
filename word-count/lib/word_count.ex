defmodule WordCount do
  @doc """
  Count the number of words in the sentence.
  
  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> get_cleaned_words()
    |> Enum.filter(&(&1 != ""))
    |> Enum.frequencies()
  end

  @spec get_cleaned_words(String.t()) :: [String.t()]
  defp get_cleaned_words(sentence) do
    for word <- String.split(sentence, [" ", "_"], trim: true) do
      word
      |> String.downcase()
      |> clean()
    end
  end

  @spec clean(String.t()) :: String.t()
  defp clean(string) do
    String.replace(string, ~r/[.,:;!?ºª§@$#%"^~'`&*()<>='"\+\|\\{\}\[\]\\\/]+/, "")
  end
end
