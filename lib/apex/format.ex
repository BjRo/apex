defprotocol Apex.Format do
  def format(data, options \\ [])
end

defimpl Apex.Format, for: BitString do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    colorize("\"#{data}\"", data, options) <> new_line
  end
end

defimpl Apex.Format, for: Integer do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    colorize("#{data}", data, options) <> new_line
  end
end

defimpl Apex.Format, for: Float do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    colorize("#{float_to_binary(data, decimals: 15, compact: true)}", data, options) <> new_line
  end
end

defimpl Apex.Format, for: Atom do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    colorize("#{data}", data, options) <> new_line
  end
end

defimpl Apex.Format, for: List do
  def format(data, options \\ []) do
    Apex.Format.Seq.format(data, options)
  end
end

defimpl Apex.Format, for: Range do
  import Apex.Format.Utils

  def format(d = %{__struct__: name, first: lower_bound, last: upper_bound}, options \\ []) do
    colorize("##{name} #{lower_bound}..#{upper_bound}", d, options) <> new_line
  end
end

defimpl Apex.Format, for: PID do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    colorize(inspect(data), data, options) <> new_line
  end
end

defimpl Apex.Format, for: Function do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    colorize(inspect(data), data, options) <> new_line
  end
end

defimpl Apex.Format, for: HashDict do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    Apex.Format.Seq.format(
      Dict.to_list(data),
      options,
      start_token: "HashDict<[",
      end_token: "]>",
      numbers: false) |> colorize(data, options)
  end
end

defimpl Apex.Format, for: HashSet do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    Apex.Format.Seq.format(
      Set.to_list(data),
      options,
      start_token: "HashSet<[",
      end_token: "]>",
      numbers: false) |> colorize(data, options)
  end
end

defimpl Apex.Format, for: Map do
  import Apex.Format.Utils

  def format(data, options \\ []) do
    Apex.Format.Seq.format(
      Map.to_list(data),
      options,
      start_token: "\%{",
      end_token: "}",
      numbers: false) |> colorize(data, options)
  end
end
