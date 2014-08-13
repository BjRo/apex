defmodule Apex.Format.Utils.Test do
  use ExUnit.Case
  import Apex.Format.Utils

  test "#next_indent_level" do
    options = []

    assert [indent_level: 1] = next_indent_level(options)
    assert [indent_level: 2] = next_indent_level([indent_level: 1])
  end

  test "#indent" do
    options = []

    assert indent(options) == ""
    assert indent([indent_level: 1]) == "  "
    assert indent([indent_level: 2]) == "    "
    assert indent([indent_level: 3]) == "      "

    assert indent([indent_level: 1, indent: 1]) == " "
    assert indent([indent_level: 2, indent: 1]) == "  "
    assert indent([indent_level: 3, indent: 1]) == "   "
  end

  test "#colorize should not do anything when it's turned off" do
    assert colorize("FOO", {}, color: false) == "FOO"
  end

  test "#colorize should color when it's asked for it" do
    assert colorize("A", 1)  == "\e[34mA\e[0m"
  end
end
