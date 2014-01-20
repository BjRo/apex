defmodule Apex.Format.Color do

  def colorize(text, data) do
    if color = color(data) do
      escape(text, color)
    else
      text
    end
  end

  defp color(data) when is_list(data),   do: "yellow"
  defp color(data) when is_tuple(data),  do: "blue"
  defp color(data) when is_binary(data), do: "red"
  defp color(data), do: nil

  defp escape(text, color) do
    IO.ANSI.escape_fragment("%{#{color}}") <> text <> IO.ANSI.escape_fragment("%{reset}")
  end
end
