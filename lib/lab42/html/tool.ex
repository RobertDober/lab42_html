defmodule Lab42.Html.Tool do

  @default_numbered_options %{start: 1, increment: 1}
  
  @doc """
  By default we will number a list starting with 1 and increment by the
  same value

        iex(0)> numbered(~w[a b c])
        [{1, "a"}, {2, "b"}, {3, "c"}]

  However one or both of these default values can be changed

        iex(1)> numbered(~w[alpha beta gamma]a, start: 40)
        [{40, :alpha}, {41, :beta}, {42, :gamma}]

        iex(2)> numbered(~w[three one minus_one], start: 3, increment: -2)
        [{3, "three"}, {1, "one"}, {-1, "minus_one"}]

  """
  def numbered(list, options \\ []) do
    _numbered(list, Enum.into(options, @default_numbered_options))
  end


  defp _numbered(list, %{start: start, increment: increment}) do
    Enum.zip(Stream.iterate(start, &(&1 + increment)), list)
  end
end
