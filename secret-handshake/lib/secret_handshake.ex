defmodule SecretHandshake do
  use Bitwise, only_operators: true
  @wink 1
  @blink 2
  @close 4
  @jump 8
  @reverse 16
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
    list = command(code, :wink) ++ command(code, :blink) 
		++ command(code, :close) ++ command(code, :jump)
    if should_reverse?(code), do: Enum.reverse(list), else: list
  end

  @spec command(code :: integer, command_key :: atom ) :: list(String.t())
  defp command(code, command_key) do
	%{:value => value, :text => text} = map_command(command_key)
	if (code &&& value) == value  do
		[text]
	else
		[]
	end
  end

  @spec should_reverse?(code :: integer) :: boolean
  defp should_reverse?(code) do
	(code &&& @reverse) == @reverse
  end

  @spec map_command(key :: atom) :: map
  defp map_command(key) do
	case key do
		:wink -> %{:value => @wink, :text => "wink"}
		:blink -> %{:value => @blink, :text => "double blink"}
		:close -> %{:value => @close, :text => "close your eyes"}
		:jump -> %{:value => @jump, :text => "jump"}
	end
  end
end
