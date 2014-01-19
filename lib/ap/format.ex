defprotocol AP.Format do
  def format(data, options // [])
end

defimpl AP.Format, for: BitString do
  def format(data, _ // []), do: "\"#{data}\"" <> AP.Format.Utils.new_line
end

defimpl AP.Format, for: Integer do
  def format(data, _ // []), do: "#{data}" <> AP.Format.Utils.new_line
end

defimpl AP.Format, for: Float do
  def format(data, _ // []) do
    "#{float_to_binary(data, decimals: 15, compact: true)}" <> AP.Format.Utils.new_line
  end
end

defimpl AP.Format, for: Atom do
  def format(data, _ // []), do: "#{data}" <> AP.Format.Utils.new_line
end

defimpl AP.Format, for: List do
  def format(data, options // []), do: AP.Format.Seq.format(data, options)
end

defimpl AP.Format, for: Range do
  def format({name, lower_bound, upper_bound}, options // []) do
    "##{name} #{lower_bound}..#{upper_bound}" <> AP.Format.Utils.new_line
  end
end

defimpl AP.Format, for: PID do
  def format(data, options // []) do
    inspect(data) <> AP.Format.Utils.new_line
  end
end

defimpl AP.Format, for: Function do
  def format(data, options // []) do
    inspect(data) <> AP.Format.Utils.new_line
  end
end

defimpl AP.Format, for: HashDict do
  def format(data, options // []) do
    AP.Format.Seq.format(
      Dict.to_list(data),
      options,
      start_token: "#HashDict <",
      end_token: ">",
      numbers: false)
  end
end

defimpl AP.Format, for: HashSet do
  def format(data, options // []) do
    AP.Format.Seq.format(
      Set.to_list(data),
      options,
      start_token: "#HashSet <",
      end_token: ">",
      numbers: false)
  end
end
