defprotocol AP.Format do
  def format(data, options // [])
end

defimpl AP.Format, for: BitString do
  import AP.Format.Utils
  def format(data, _ // []), do: "\"#{data}\"" <> new_line
end

defimpl AP.Format, for: Integer do
  import AP.Format.Utils
  def format(data, _ // []), do: "#{data}" <> new_line
end

defimpl AP.Format, for: Atom do
  import AP.Format.Utils
  def format(data, _ // []), do: "#{data}" <> new_line
end

defimpl AP.Format, for: List do
  import AP.Format.Utils
  def format(data, options // []), do: AP.Format.Seq.format(data, "[", "]", options)
end
