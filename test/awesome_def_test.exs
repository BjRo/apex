defmodule AwesomeDefTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  require Apex.AwesomeDef
  import Apex.AwesomeDef

  adef foo(test), do: test

  test "can run wrap def with awesome_def" do
    output = assert capture_io(fn -> foo("test") end)
    assert output =~ "[36mElixir.AwesomeDefTest.foo\e[0m was called"
  end
end
