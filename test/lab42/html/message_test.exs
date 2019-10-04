defmodule Lab42.Html.MessageTest do
  use ExUnit.Case

  import Lab42.Html.Message
  
  describe "result extraction" do
    test "of an ok result" do
      result = result(42, [])
      assert extract!(result) == 42
    end
  end
end
