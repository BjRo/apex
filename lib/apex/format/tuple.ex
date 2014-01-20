defimpl Apex.Format, for: Tuple do
  import Apex.Format.Utils
  alias  Apex.Format.Seq

  def format(data, options // [])  do
    do_format(data, options)
  end

  defp do_format({key, value}, options) when is_atom(key) do
    "#{key}: " <> Apex.Format.format(value, options)
  end

  defp do_format(data, options) when is_record(data) do
    {pre, entries} = if function_exported?(data, :__record__, 1) do
      { "##{data.__record__(:name)} {", data.to_keywords }
    else
      { "{", tuple_to_list(data) }
    end

    Seq.format(entries, options, start_token: pre, end_token: "}")
  end

  defp do_format(data, options) do
    Seq.format(tuple_to_list(data), options, start_token: "{", end_token: "}")
  end
end
