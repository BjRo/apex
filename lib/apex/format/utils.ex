defmodule Apex.Format.Utils do
  @default_indent 2
  @default_level 0

  def new_line, do: "\n"

  def colorize(str, data, options \\ []) do
    Apex.Format.Color.colorize(str, data, options)
  end

  def separator_line(str, length \\ 100) do
    String.duplicate(str, length)
      |> Apex.Format.Color.escape(:yellow)
  end

  def next_indent_level(options) do
    Keyword.update(options, :indent_level, 1, &( &1 + 1))
  end

  def indent(options) do
    String.duplicate("\s", level(options) * step(options))
  end

  defp step(options) do
    Keyword.get(options, :indent, @default_indent)
  end

  defp level(options)  do
    Keyword.get(options, :indent_level, @default_level)
  end
end
