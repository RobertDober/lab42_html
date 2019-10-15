defmodule Lab42.Html do
  @moduledoc """
  Very simple generators for HTML Elements
  """

  @doc """

        iex(0)> data = [
        ...(0)>   ["header1", "header2"],
        ...(0)>   ["cell1", "cell2"]]
        ...(0)> gen_table(data)
        {:ok, "<table>\\n<thead>\\n<tr>\\n<th>\\nheader1\\n</th>\\n<th>\\nheader2\\n</th>\\n</tr>\\n</thead>\\n<tbody>\\n<tr>\\n<td>\\ncell1\\n</td>\\n<td>\\ncell2\\n</td>\\n</tr>\\n</tbody>\\n</table>\\n", []}

  Headers can, but probably shall not, be avoided, also we expose `Lab42.Html.Table.gen/2` as `gen_table/2`

        iex(1)> data = [
        ...(1)>  ~w(no_header no_header),
        ...(1)>  ~w(cell21 cell22)]
        ...(1)> gen_table(data, false)
        {:ok,
        "<table>\\n<tbody>\\n<tr>\\n<td>\\nno_header\\n</td>\\n<td>\\nno_header\\n</td>\\n</tr>\\n<tr>\\n<td>\\ncell21\\n</td>\\n<td>\\ncell22\\n</td>\\n</tr>\\n</tbody>\\n</table>\\n",
        []}

  """
  def gen_table(data, thead \\ true), do: Lab42.Html.Table.gen(data, thead)
end
