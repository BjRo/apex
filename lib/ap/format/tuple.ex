defimpl AP.Format, for: Tuple do
  import AP.Format.Utils

  def format(data, options // []),  do: do_format(data, options)

  defp do_format({key, value}, options) when is_atom(key) do
    "#{key}: " <> AP.Format.format(value, options)
  end

  defp do_format(data, options) do
    {pre, entries} = if function_exported?(data, :__record__, 1) do
      { record_name, record_data } =  record_content(data)
      { "#{record_name} {", record_data }
    else
      { "{", tuple_to_list(data) }
    end

    AP.Format.Seq.format(entries, pre, "}", options)
  end

  defp record_content(data) do
    [ record_name | rest] = tuple_to_list(data)

    record_data = data.__record__(:fields)
      |> Enum.map(&elem(&1, 0))
      |> Enum.zip(rest)

    { record_name, record_data }
  end
end
