defmodule Apex.Test do
  use ExUnit.Case
  import Apex
  import ExUnit.CaptureIO

  test "#ap without label" do
    output = capture_io(fn ->
      ap([first_name: "John", last_name: "Doe"], color: false)
    end)
    assert output == """
    [
      [0] first_name: "John"
      [1] last_name: "Doe"
    ]

    """
  end

  test "#ap with label" do
    output = capture_io(fn ->
      ap([first_name: "John", last_name: "Doe"], color: false, label: "some label")
    end)
    assert output == """
    some label: [
      [0] first_name: "John"
      [1] last_name: "Doe"
    ]

    """
  end
end
