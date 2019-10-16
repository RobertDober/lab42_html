defmodule Lab42.Html.TableTest do
  use ExUnit.Case

  import Lab42.Html.Table, only: [gen: 1, gen: 2]
  import Support.GenHtml 

  describe "vanilla table" do
    test "simplest error free case" do
      data = [["head"], ["tail"]]
      html = gen_table(data)
      result = gen(data)

      assert result == {:safe, html}
    end
    test "a little bit more complicated" do
      data = [~w{h1 h2}, ~w{b1, b2}, ~w{b3 b4}]
      html = gen_table(data)
      result = gen(data)

      assert result == {:safe, html}
    end
  end

  describe "some errors and warnings" do
    test "no data" do
      data     = []
      html     = ""
      result   = gen(data)
      messages = [{:error, "Empty Data cannot create a table", 0}]

      assert result == {:error, html, messages} 
    end
    test "head is not a list" do
      data     = ~w{head}
      html     = ""
      result   = gen(data)
      messages = [{:fatal, "Data is not a list of lists", 0}]

      assert result == {:error, html, messages} 
    end
    test "or is empty" do
      data     = [[]]
      html     = ""
      result   = gen(data)
      messages = [{:error, "Empty thead list does not make much sense", 1}]

      assert result == {:error, html, messages} 
    end
    test "if columns do not correspond" do
      data     = [~w(alpha beta), ~w{only_one}] 
      html     = gen_table(data)
      result   = gen(data)
      messages = [{:error, "Column count does not correspond to previous cells", 2}]
      assert result == {:error, html, messages} 
    end
  end

  describe "thead is false" do
    test "a little bit more complicated" do
      data = [~w{n1 n2}, ~w{b1, b2}, ~w{b3 b4}]
      html = gen_table(data, false)
      result = gen(data, false)

      assert result == {:safe, html}
    end
    test "if columns do not correspond" do
      data     = [~w(alpha beta), ~w{only_one}] 
      html     = gen_table(data, false)
      result   = gen(data, false)
      messages = [{:error, "Column count does not correspond to previous cells", 2}]
      assert result == {:error, html, messages} 
    end
  end

end
