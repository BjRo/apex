defprotocol AP.Format do
  def format(data, options // [])
end

defimpl AP.Format, for: BitString do
  def format(data, _ // []), do: "\"#{data}\"" <> AP.Format.Utils.new_line
end

defimpl AP.Format, for: Integer do
  def format(data, _ // []), do: "#{data}" <> AP.Format.Utils.new_line
end

defimpl AP.Format, for: Atom do
  def format(data, _ // []), do: "#{data}" <> AP.Format.Utils.new_line
end

defimpl AP.Format, for: List do
  def format(data, options // []), do: AP.Format.Seq.format(data, "[", "]", options)
end

defimpl AP.Format, for: Record do
  def format(data, options // []), do: "RECORD"
end
