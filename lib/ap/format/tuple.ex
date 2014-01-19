defimpl AP.Format, for: Tuple do
  import AP.Format.Utils

  def format(data, options // []),  do: do_format(data, options)

  defp do_format({key, value}, options) when is_atom(key) do
    "#{key}: " <> AP.Format.format(value, options)
  end

  defp do_format(data, options) do
    {pre, entries} = if function_exported?(data, :__record__, 1) do
      { "#{data.__record__(:name)} {", data.to_keywords }
    else
      { "{", tuple_to_list(data) }
    end

    AP.Format.Seq.format(entries, pre, "}", options)
  end
end
