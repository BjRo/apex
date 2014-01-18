defmodule AP.Format.Test do
  use ExUnit.Case
  import AP.Format

  test "Can format integers" do
    assert format(1, color: false) == "1\n"
  end
end
