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

  @doc """
  Wrap result depending on options, by default we will wrap
  for usage in Phoenix templates.

        iex(3)> result([], "42")
        {:safe, "42"}

  It also transforms bindata into a string if necessary

        iex(4)> result([], ["4", ["2"]])
        {:safe, "42"}

  In the case of an error that transformation still works

        iex(5)> result([{:error, "typo", nil}], ["42"])
        {:error, "42", [{:error, "typo", nil}]}

  And last, but not least, the success tag can be changed

        iex(6)> result([], ~w{hello world}, success_tag: :ok)
        {:ok, "helloworld"}
  """
  def result( messages, value, options \\ [])
  def result( messages, value, options) when is_binary(value) do
    case Lab42.Message.result(messages, value) do
      {:ok, value1, _} -> _wrap_ok(value1, options)
      error_result     -> error_result
    end
  end
  def result(messages, value, options) do
    result(messages, IO.iodata_to_binary(value), options)
  end

  
  defp _numbered(list, %{start: start, increment: increment}) do
    Enum.zip(Stream.iterate(start, &(&1 + increment)), list)
  end

  defp _wrap_ok(value, options) do
    {Keyword.get(options, :success_tag, :safe), value}
  end

end
