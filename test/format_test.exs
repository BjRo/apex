defmodule Apex.Format.Test do
  use ExUnit.Case
  import Apex.Format

  test "Can format references" do
    reference = make_ref()
    assert format(reference, color: false) =~ ~r/#Reference<\d+\.\d+\.\d+\.\d+>/
  end

  test "Can format a list of strings" do
    assert format(~w(a b c d), color: false) == """
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

  test "Can format floats" do
    assert format(1.1, color: false) == "1.1\n"
  end

  test "Can format atoms" do
    assert format(true, color: false) == "true\n"
    assert format(false, color: false) == "false\n"
  end

  test "Can format keyword list" do
    assert format([first_name: "John", last_name: "Doe"], color: false) == """
    [
      [0] first_name: "John"
      [1] last_name: "Doe"
    ]
    """
  end

  test "Can format empty tuples" do
    assert format({}, color: false) == "{}\n"
  end

  test "Can format tuples that don't start with an atom" do
    assert format({1, "John", 1, true}, color: false) == """
    {
      [0] 1
      [1] "John"
      [2] 1
      [3] true
    }
    """
  end

  test "Can format tuples that start with an atom" do
    assert format({:name, "John"}, color: false) == """
    {
      [0] :name
      [1] "John"
    }
    """
  end

  test "Can format second level tuples in a map" do
    map = %{
      some_key: {:name, "John"}
    }

    assert format(map, color: false) == """
    %{
      some_key: {
        [0] :name
        [1] "John"
      }
    }
    """
  end

  test "Can format ranges" do
    assert format(1..2, color: false) == """
    #Elixir.Range 1..2
    """
  end

  test "Can format pid" do
    assert format(self(), color: false) =~ ~r(#PID<0.\d+.0>\n)
  end

    test "Can format port" do
    assert format(Port.list |> List.first, color: false) =~ ~r(#Port<0.\d+>\n)
  end

  test "Can format function" do
    f = fn(a) -> "#{a}" end
    assert format(f, color: false) =~ ~r(#Function<0.\d+/1 in Apex.Format.Test."test Can format function"/1>\n)
  end

  test "Can format MapSets" do
    set = MapSet.new |> MapSet.put(:foo) |> MapSet.put(:baz)
    assert format(set, color: false) == """
    MapSet<[
      :baz
      :foo
    ]>
    """
  end

  require Record
  Record.defrecord :user, [first_name: nil, last_name: nil]
  test "Can format records" do
    assert format(user(first_name: "John", last_name: "Doe"), color: false) == """
    user{
      [0] "John"
      [1] "Doe"
    }
    """
  end

  test "Can format Maps" do
    map = %{foo: "bar", bar: "baz"}
    assert format(map, color: false) == """
    %{
      bar: "baz"
      foo: "bar"
    }
    """
  end

  defmodule TestStruct, do: defstruct first_name: nil, last_name: nil
  test "Can format structs" do
    assert format(%TestStruct{first_name: "John", last_name: "Doe"} , color: false) == """
    %Elixir.Apex.Format.Test.TestStruct{
      first_name: "John"
      last_name: "Doe"
    }
    """
  end

  test "Can turn off list numbering" do
    data = [false, 42, ~w(forty two), [time: "now"], %{foo: :bar}]

    assert format(data, numbers: false, color: false) == """
    [
      false
      42
      [
        "forty"
        "two"
      ]
      [
        time: "now"
      ]
      %{
        foo: :bar
      }
    ]
    """
  end
end
