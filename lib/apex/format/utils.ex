defmodule Apex.Format.Utils do
  @default_indent 2
  @default_level 0

  def new_line, do: "\n"

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
