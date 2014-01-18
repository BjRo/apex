defmodule AP.Format.Test do
  use ExUnit.Case
  import AP.Format

  test "Can format a list of strings" do
    assert format(%w(a b c d), color: false) == """
    [
      [0] "a"
      [1] "b"
      [2] "c"
      [3] "d"
    ]
    """
  end

  test "Can format a list containing a list" do
    assert format(["a", "b", ["c", "d"]], color: false) == """
    [
      [0] "a"
      [1] "b"
      [2] [
        [0] "c"
        [1] "d"
      ]
    ]
    """
  end

  test "Can format integers" do
    assert format(1, color: false) == "1\n"
  end

  test "Can format atoms" do
    assert format(true, color: false) == "true\n"
    assert format(false, color: false) == "false\n"
  end

  test "Can keyword list" do
    assert format([first_name: "John", last_name: "Doe"], color: false) == """
    [
      [0] first_name: "John"
      [1] last_name: "Doe"
    ]
    """
  end
end
