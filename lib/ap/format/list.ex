defimpl AP.Format, for: List do
  import AP.Format.Utils

  def format(data, options // []) do
    pre  =  "[#{new_line}"
    post =  indent(options) <> "]#{new_line}"
    pre <> do_format(data, next_indent_level(options)) <> post
  end

  defp do_format(data, options) when is_list(data) do
    Stream.with_index(data)
      |> Enum.map(&do_format(&1, options))
      |> Enum.join
  end

  defp do_format({entry, i}, options) do
    indent(options) <> "[#{i}] " <> AP.Format.format(entry, options)
  end
end
