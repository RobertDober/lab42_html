defmodule Lab42.Html.Table do

  import Lab42.Html.Message
  import Lab42.Html.Tool, only: [numbered: 1]

  @moduledoc """
  Generates HTML Tables from list data.
  """
  
  @dpc false
  def gen(data, thead \\ true)
  def gen(data, true) do
    {thead, rest, cols, messages} = _gen_thead(numbered(data), [])
    {tbody, {_, messages1}}       = _gen_tbody(rest, cols, 2, messages)

    result(
      ["<table>\n<thead>\n<tr>\n", thead, "</tr>\n</thead>\n<tbody>\n", tbody, "</tbody>\n</table>\n"]
      |> IO.iodata_to_binary,
      messages1)
  end

  defp _gen_row(lnb_n_cell, col_n_messages)
  defp _gen_row({lnb, cells}, {cols, messages}) when is_list(cells) do
    messages1 =
      if Enum.count(cells) != cols,
        do: add_message(messages, "Column count does not correspond to previous cells", severity: :warning),
        else: messages
    result = Enum.map(cells, &_gen_td/1)
    {["<tr>\n", result, "</tr>\n"], {cols, messages1}}
  end
  defp _gen_row({lnb, _cells}, {cols, messages}) do 
    {"", {cols, add_message(messages, "Data row is not a list, ignored!")}} 
  end

  defp _gen_tbody(data, cols, start, messages)
  defp _gen_tbody([], _cols, start, messages) do
    {"", add_message(messages, "Empty Body Data cannot create a table body", location: start)}
  end
  defp _gen_tbody(data, cols, start, messages) do
    Enum.map_reduce(data, {cols, messages}, &_gen_row/2)
  end

  defp _gen_td(cell), do: ["<td>\n", to_string(cell), "\n</td>\n"]

  defp _gen_thead(data, messages)
  defp _gen_thead([], messages) do
    {"", [], 0, add_message(messages, "Empty Data cannot create a table")}
  end
  defp _gen_thead([{lnb, thead}|rest], messages) when is_list(thead) do
    case _gen_thead_ok(thead, [], 0) do
      {repr, 0}    ->
        {"", rest, nil,
          add_message(messages, "Empty thead list does not make much sense", location: lnb, severity: :warning)}
      {repr, cols} -> {repr, rest, cols, messages}
    end
  end
  defp _gen_thead(data, messages) do
    IO.inspect {9999, data}
    {"", [], 0, add_message(messages, "Data is not a list of lists", severity: :fatal)}
  end

  defp _gen_thead_ok(cells, result, cols)
  defp _gen_thead_ok([], result, cols) do
    {result, cols}
  end
  defp _gen_thead_ok([cell|cells], result, cols) do
    _gen_thead_ok(cells, [result, "<th>\n", to_string(cell), "\n</th>\n"], cols + 1)
  end

end
