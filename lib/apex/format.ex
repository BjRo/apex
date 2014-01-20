defprotocol Apex.Format do
  def format(data, options // [])
end

defimpl Apex.Format, for: BitString do
  def format(data, _ // []), do: "\"#{data}\"" <> Apex.Format.Utils.new_line
end

defimpl Apex.Format, for: Integer do
  def format(data, _ // []), do: "#{data}" <> Apex.Format.Utils.new_line
end

defimpl Apex.Format, for: Float do
  def format(data, _ // []) do
    "#{float_to_binary(data, decimals: 15, compact: true)}" <> Apex.Format.Utils.new_line
  end
end

defimpl Apex.Format, for: Atom do
  def format(data, _ // []), do: "#{data}" <> Apex.Format.Utils.new_line
end

defimpl Apex.Format, for: List do
  def format(data, options // []), do: Apex.Format.Seq.format(data, options)
end

defimpl Apex.Format, for: Range do
  def format({name, lower_bound, upper_bound}, options // []) do
    "##{name} #{lower_bound}..#{upper_bound}" <> Apex.Format.Utils.new_line
  end
end

defimpl Apex.Format, for: PID do
  def format(data, options // []) do
    inspect(data) <> Apex.Format.Utils.new_line
  end
end

defimpl Apex.Format, for: Function do
  def format(data, options // []) do
    inspect(data) <> Apex.Format.Utils.new_line
  end
end

defimpl Apex.Format, for: HashDict do
  def format(data, options // []) do
    Apex.Format.Seq.format(
      Dict.to_list(data),
      options,
      start_token: "#HashDict <",
      end_token: ">",
      numbers: false)
  end
end

defimpl Apex.Format, for: HashSet do
  def format(data, options // []) do
    Apex.Format.Seq.format(
      Set.to_list(data),
      options,
      start_token: "#HashSet <",
      end_token: ">",
      numbers: false)
  end
end
