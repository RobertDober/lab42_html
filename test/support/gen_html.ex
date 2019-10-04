defmodule Support.GenHtml do

  def gen_html(_data) do
    ""
  end

  def gen_table([header|data]) do
    [ "<table>\n",  _push(~w[thead tr], "th", header),
      _push("tbody", _w(~w[tr td], data)),
      "</table>\n" ]
    |> IO.iodata_to_binary
  end


  defp _push(tags, content) do
    {openers, closers} = _s(tags)
    [openers, content, closers]
  end
  defp _push(tags, tag, content) do
    {openers, closers} = _s(tags)
    [openers, _ct(tag, content), closers]
  end

  defp _ct(tag, content)
  defp _ct(tag, content) when is_list(content),
    do: Enum.map(content, &_ct(tag, &1))
  defp _ct(tag, content), do: ["<#{tag}>\n", content, "\n</#{tag}>\n"]

  defp _s(tags)
  defp _s(tag) when is_binary(tag), do: _t([tag], [], [])
  defp _s(tags), do: _t(tags, [], [])

  defp _t(tags, openers, closers)
  defp _t([], openers, closers), do: {openers, closers}
  defp _t([tag|rest], openers, closers) do
    _t(rest, [openers, "<#{tag}>\n"], ["</#{tag}>\n" | closers])
  end

  defp _w(wrappers, lists)
  defp _w([wrapper], list) do
    Enum.map(list, &["<", wrapper, ">\n", to_string(&1), "\n</", wrapper, ">\n"])
  end
  defp _w([wrapper|rest], lists) do
    Enum.map(lists, &["<", wrapper, ">\n", _w(rest, &1), "</", wrapper, ">\n"])
  end
end
