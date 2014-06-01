defmodule Apex.Format.Color.Test do
  use ExUnit.Case
  import Apex.Format.Color

  test "#colorize should color text based on the type" do
    assert colorize("Tuple should be blue", {}) == "\e[1;34mTuple should be blue\e[0m"
  end

  test "#escape generates the correct pattern matches" do
    assert escape("A", :gray)    == "\e[1;30mA\e[0m"
    assert escape("A", :grayish) == "\e[0;30mA\e[0m"
    assert escape("A", :red)     == "\e[1;31mA\e[0m"
    assert escape("A", :redish)  == "\e[0;31mA\e[0m"
  end
end
