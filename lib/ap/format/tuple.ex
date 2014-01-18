defimpl AP.Format, for: Tuple do
  import AP.Format.Utils

  def format(data, options // []),  do: do_format(data, options)

  defp do_format({key, value}, options) when is_atom(key) do
    "#{key}: " <> AP.Format.format(value, options)
  end

  defp do_format(data, options) do
    tuple_to_list(data) |> AP.Format.Seq.format("{", "}", options)
  end
end
