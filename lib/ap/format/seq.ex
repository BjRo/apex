defmodule AP.Format.Seq do
  import AP.Format.Utils

  def format(data, options, config // []) do
    pre  =  start_token(config) <> new_line
    post =  indent(options) <> end_token(config) <> new_line
    pre <> do_format(data, next_indent_level(options), config) <> post
  end

  defp do_format(data, options, config) when is_list(data) do
    Stream.with_index(data)
      |> Enum.map(&do_format(&1, options, config))
      |> Enum.join
  end

  defp do_format({entry, i}, options, config) do
    number = if numbers?(config), do: "[#{i}] ", else: ""
    indent(options) <> number <> AP.Format.format(entry, options)
  end

  defp start_token(config), do: config[:start_token] || "["
  defp end_token(config), do: config[:end_token] || "]"
  defp numbers?(config), do: config[:numbers] != false
end
