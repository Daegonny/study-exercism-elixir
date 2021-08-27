defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
	String.split(sentence, [" ", "_"], trim: true)
	|> Enum.map(&String.downcase/1)
	|> Enum.map(&clean/1)
	|> Enum.filter(fn x -> x != "" end)
    |> Enum.frequencies()
  end

  @spec clean(String.t()) :: String.t()
  defp clean(string) do
	String.replace(string, ~r/[.,:;!?ºª§@$#%"^~'`&*()<>='"\+\|\\{\}\[\]\\\/]+/, "")
  end
end
