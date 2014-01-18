defmodule AP.Format.List.Test do
  use ExUnit.Case
  import AP.Format.Utils

  test "indentation works", context do
    data = "A"
    options = []
    no_op = fn(d, o) -> d end

    assert indented(data, options, no_op) == "A"
    assert indented(data, [indent_level: 1], no_op) == " A"
    assert indented(data, [indent_level: 2], no_op) == "  A"
    assert indented(data, [indent_level: 3], no_op) == "   A"

    assert indented(data, [indent_level: 0, indent: 2], no_op) == "A"
    assert indented(data, [indent_level: 1, indent: 2], no_op) == "  A"
    assert indented(data, [indent_level: 2, indent: 2], no_op) == "    A"
    assert indented(data, [indent_level: 3, indent: 2], no_op) == "      A"
  end
end
