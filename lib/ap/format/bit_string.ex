defimpl AP.Format, for: BitString do
  def format(data, _ // []), do: "\"#{data}\""
end

