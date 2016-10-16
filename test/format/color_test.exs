defmodule Apex.Format.Color.Test do
  use ExUnit.Case
  use Apex.Format.Color

  test "#colorize should color text based on the type" do
    assert colorize("Tuple should be blue", {}) == "\e[34mTuple should be blue\e[0m"
  end

  test "#colorize should allow for runtime override of colors" do
    Application.put_env(:apex, :colors, %{binary: :red})
    assert colorize("Binary should be red", "") == "\e[31mBinary should be red\e[0m"
  end

  test "#escape generates the correct pattern matches" do
    assert escape("A", :red)     == "\e[31mA\e[0m"
  end
end
