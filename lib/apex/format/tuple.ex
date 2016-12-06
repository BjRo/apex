defimpl Apex.Format, for: Tuple do
  import Apex.Format.Utils
  alias  Apex.Format.Seq

  def format(data, options \\ [])  do
    do_format(data, options)
  end

  defp do_format({key, value}, options) when is_atom(key) and not key in [true, false, nil] do
    colorize("#{key}: ", key, options) <> Apex.Format.format(value, options)
  end

  defp do_format({}, _options), do: "{}" <> new_line()
  defp do_format(data, options) do
    seq = Tuple.to_list(data)
    head = hd(seq)
    if is_atom(head) and not head in [true, false, nil] do
      Seq.format(tl(seq), options, start_token: "#{head}{", end_token: "}")
    else
      Seq.format(Tuple.to_list(data), options, start_token: "{", end_token: "}")
    end
  end
end
