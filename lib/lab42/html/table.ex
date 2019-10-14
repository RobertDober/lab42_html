defmodule Lab42.Html.Table do

  import Lab42.Message
  import Lab42.Html.Tool, only: [numbered: 1]

  @moduledoc """
  Generates HTML Tables from list data.
  """
  
  @doc false
  def gen(data, thead \\ true)
  def gen(data, true) do
    case _gen_thead(numbered(data), []) do
      {_, _, 0, messages}           -> result(messages(messages), "")
      {thead, rest, cols, messages} -> _gen_table(thead, rest, cols, 2, messages)
     end
  end
  def gen(data, false) do
    {tbody, {_, messages}} = _gen_tbody(numbered(data), nil, 1, [])
    result(messages,
      ["<table>\n<tbody>\n", tbody, "</tbody>\n</table>\n"] |> IO.iodata_to_binary)
  end


  defp _gen_table(thead, rest, cols, start, messages) do
    {tbody, {_, messages1}} = _gen_tbody(rest, cols, start, messages)
    result(messages1,
      ["<table>\n<thead>\n<tr>\n", thead, "</tr>\n</thead>\n<tbody>\n", tbody, "</tbody>\n</table>\n"]
      |> IO.iodata_to_binary)
  end

  defp _gen_row(lnb_n_cell, col_n_messages)
  defp _gen_row({lnb, cells}, {cols, messages}) when is_list(cells) do
    messages1 =
      if cols && Enum.count(cells) != cols,
        do: add_warning(messages, "Column count does not correspond to previous cells", lnb),
        else: messages
    result = Enum.map(cells, &_gen_td/1)
    {["<tr>\n", result, "</tr>\n"], {cols, messages1}}
  end
  defp _gen_row({lnb, _cells}, {cols, messages}) do 
    {"", {cols, add_error(messages, "Data row is not a list, ignored!", lnb)}} 
  end

  defp _gen_tbody(data, cols, start, messages)
  defp _gen_tbody([], cols, start, messages) do
    {"", {cols, add_error(messages, "Empty Body Data cannot create a table body", start)}}
  end
  defp _gen_tbody(data, cols, _start, messages) do
    Enum.map_reduce(data, {cols, messages}, &_gen_row/2)
  end

  defp _gen_td(cell), do: ["<td>\n", to_string(cell), "\n</td>\n"]

  defp _gen_thead(data, messages)
  defp _gen_thead([], messages) do
    {"", [], 0, add_error(messages, "Empty Data cannot create a table", 0)}
  end
  defp _gen_thead([{lnb, thead}|rest], messages) when is_list(thead) do
    case _gen_thead_ok(thead, [], 0) do
      {_repr, 0}    ->
        {"", rest, 0,
          add_error(messages, "Empty thead list does not make much sense", lnb)}
      {repr, cols} -> {repr, rest, cols, messages}
    end
  end
  defp _gen_thead(_data, messages) do
    {"", [], 0, add_fatal(messages, "Data is not a list of lists", 0)}
  end

  defp _gen_thead_ok(cells, result, cols)
  defp _gen_thead_ok([], result, cols) do
    {result, cols}
  end
  defp _gen_thead_ok([cell|cells], result, cols) do
    _gen_thead_ok(cells, [result, "<th>\n", to_string(cell), "\n</th>\n"], cols + 1)
  end

end
