defmodule Lab42.Html.ToolTest do
  use ExUnit.Case

  import Lab42.Html.Tool, only: [numbered: 1, numbered: 2]

  describe "numbered" do
    test "default" do
      assert numbered(~w{one two}) == [{1, "one"}, {2, "two"}]
    end

    test "differnt start" do
      assert numbered(~w{one two}, start: 42) == [{42, "one"}, {43, "two"}]
    end

    test "different increment" do
      assert numbered(~w{one two}, increment: 2) == [{1, "one"}, {3, "two"}]
    end

    test "why not crazy?" do
      assert numbered(~w{three four five}a, start: 5, increment: -3) ==
        [{5, :three}, {2, :four}, {-1, :five}]
    end

    test "edge case" do
      assert numbered([], start: :hello, increment: "alpha") == []
    end
  end
end
