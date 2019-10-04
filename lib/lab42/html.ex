defmodule Lab42.Html do
  @moduledoc """
  Very simple generators for HTML Elements

  Its main purpose is to convert lists into HTML, here is the cannonical
  example

        iex(0)> data = [
        ...(0)>   ["header1", "header2"],
        ...(0)>   ["cell1", "cell2"]]
        ...(0)> Lab42.Html.Table.gen(data)
        {:ok, "<table>\\n<thead>\\n<tr>\\n<th>\\nheader1\\n</th>\\n<th>\\nheader2\\n</th>\\n</tr>\\n</thead>\\n<tbody>\\n<tr>\\n<td>\\ncell1\\n</td>\\n<td>\\ncell2\\n</td>\\n</tr>\\n</tbody>\\n</table>\\n", []}
  """

end
