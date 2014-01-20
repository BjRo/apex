defmodule Apex.Format.Color.Test do
  use ExUnit.Case
  import Apex.Format.Color

  test "#colorize should color text based on the type" do
    assert colorize("Tuple should be yellow", {}) == "\e[34mTuple should be yellow\e[0m"
  end
end
