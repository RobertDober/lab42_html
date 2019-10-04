defmodule Lab42.Html.TableTest do
  use ExUnit.Case

  import Lab42.Html.Table, only: [gen: 1]
  import Support.GenHtml 

  describe "vanilla table" do
    test "simplest error free case" do
      data = [["head"], ["tail"]]
      html = gen_table(data)
      result = gen(data)

      assert result == {:ok, html, []}
    end
    test "a little bit more complicated" do
      data = [~w{h1 h2}, ~w{b1, b2}, ~w{b3 b4}]
      html = gen_table(data)
      result = gen(data)

      assert result == {:ok, html, []}
    end
  end

  describe "some errors and warnings" do
    test "no data" do
      data = []
      html = ""
      result = gen(data)
      messages = [{:error, "Empty Data cannot create a table", 0}]

      assert result == {:error, html, messages} 
    end
  end
  
end
