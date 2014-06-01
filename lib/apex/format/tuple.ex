defimpl Apex.Format, for: Tuple do
  import Apex.Format.Utils
  alias  Apex.Format.Seq

  def format(data, options \\ [])  do
    do_format(data, options)
  end

  defp do_format({key, value}, options) when is_atom(key) do
    colorize("#{key}: ", key, options) <> Apex.Format.format(value, options)
  end

  defp do_format(data, options) do
    hd = :erlang.element(1, data)

    if is_atom(hd) && function_exported?(hd, :to_keywords, 1) do
      Seq.format(data.to_keywords, options, start_token: "#{hd}[", end_token: "]")
    else
      Seq.format(tuple_to_list(data), options, start_token: "{", end_token: "}")
    end
  end
end
