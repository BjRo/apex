defmodule AP.Format.Utils do
  @default_indent 1
  @default_level 1

  def indented(data, options, action) do
    indent = next_level(options) |> create_indent
    indent <> action.(data, options)
  end

  defp create_indent(options) do
    0..((level(options) - 1) * step(options))
      |> Enum.drop(1)
      |> Enum.map(fn(_) -> "\s" end)
      |> Enum.join
  end

  defp next_level(options) do
    Keyword.update(options, :indent_level, @default_level, &( &1 + 1))
  end

  defp step(options) do
    options[:indent] || @default_indent
  end

  defp level(options), do: Keyword.get(options, :indent_level)
end
