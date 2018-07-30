defimpl Apex.Format, for: Tuple do
  import Apex.Format.Utils
  alias  Apex.Format.Seq

  def format(data, options \\ [])  do
    do_format(data, options)
  end

  defp do_format({}, _options), do: "{}" <> new_line()
  defp do_format(data, options) do
    [record_name | record_detail] = Tuple.to_list(data)

    if looks_like_a_record?(record_name, record_detail) do
      format_record(record_name, record_detail, options)
    else
      Seq.format(Tuple.to_list(data), options, start_token: "{", end_token: "}")
    end
  end

  defp looks_like_a_record?(name, detail)
  defp looks_like_a_record?(name, detail) when is_atom(name) and not(name in [true, false, nil]) and length(detail) > 1, do: true
  defp looks_like_a_record?(_name, _detail), do: false

  defp format_record(name, detail, options) do
    Seq.format(detail, options, start_token: "#{name}{", end_token: "}")
  end
end
