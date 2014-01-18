defimpl AP.Format, for: BitString do
  import AP.Format.Utils

  def format(data, _ // []), do: "\"#{data}\"" <> new_line
end

