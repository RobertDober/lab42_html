defmodule Lab42.Html.Tool do

  @default_numbered_options %{start: 1, increment: 1}
  
  @doc """
  """
  def numbered(list, options \\ []) do
    _numbered(list, Enum.into(options, @default_numbered_options))
  end


  defp _numbered(list, %{start: start, increment: increment}) do
    Enum.zip(Stream.iterate(start, &(&1 + increment)), list)
  end
end
