defmodule Apex.Format.Seq do
  import Apex.Format.Utils
  @list []

  def format_set(name, data, options \\ []) do
    data
     |> to_sorted_list
     |> format(options, start_token: "#{name}<[", end_token: "]>", numbers: false)
     |> colorize(data, options)
  end

  def format(data, options, config \\ []) do
    pre  = start_token(config) <> new_line()
    post = indent(options) <> end_token(config) <> new_line()
    pre <> do_format(data, next_indent_level(options), config) <> post
  end

  defp do_format(data, options, config) when is_list(data) do
    Stream.with_index(data)
      |> Enum.map(&do_format(&1, options, config))
      |> Enum.join
  end

  defp do_format({entry, i}, options, config) do
    number = if numbers?(options, config) do
      colorize("[#{i}] ", @list, options)
    else
      ""
    end
    indent(options) <> number <> format_entry(entry, options)
  end

  defp format_entry(entry, options)
  defp format_entry({key, value}, options) when is_atom(key) and not(key in [true, false, nil]) do
    colorize("#{key}: ", key, options) <> Apex.Format.format(value, options)
  end
  defp format_entry(entry, options) do
    Apex.Format.format(entry, options)
  end

  defp start_token(config), do: config[:start_token] || "["

  defp end_token(config), do: config[:end_token] || "]"

  defp numbers?(options, config) do
    if options[:numbers] == false do
      false
    else
      config[:numbers] != false
    end
  end

  defp to_sorted_list(data) do
    data
     |> MapSet.to_list
     |> Enum.sort
  end
end
