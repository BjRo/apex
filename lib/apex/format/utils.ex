defmodule Apex.Format.Utils do
  @default_indent 2
  @default_level 0

  def new_line, do: "\n"

  def colorize(str, data, options \\ []) do
    Apex.Format.Color.colorize(str, data, options)
  end

  def separator_line(str, length \\ 100) do
    Stream.repeatedly(fn -> str end)
      |> Enum.take(100)
      |> Enum.join
      |> Apex.Format.Color.escape(:yellow)
  end

  def next_indent_level(options) do
    Keyword.update(options, :indent_level, 1, &( &1 + 1))
  end

  def indent(options) do
     0..(level(options) * step(options))
      |> Enum.uniq
      |> Enum.drop(1)
      |> Enum.map(fn(_) -> "\s" end)
      |> Enum.join
  end

  defp step(options) do
    options[:indent] || @default_indent
  end

  defp level(options)  do
    Keyword.get(options, :indent_level) || @default_level
  end
end
