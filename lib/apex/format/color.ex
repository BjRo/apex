defmodule Apex.Format.Color do
  def colorize(text, data) do
    if color = color(data) do
      escape(text, color)
    else
      text
    end
  end

  def escape(text, color), do: do_escape(text, color)

  defp color(data) when is_list(data),   do: :yellow
  defp color(data) when is_tuple(data),  do: :blue
  defp color(data) when is_binary(data), do: :red
  defp color(data), do: nil

  #   \e => escape
  #   30 => color base
  #    1 => bright
  #    0 => normal
  [
    gray: :black,
    red:  :darkred,
    green: :darkgreen,
    yellow: :brown,
    blue: :navy,
    purple: :darkmagenta,
    cyan: :darkcyan,
    white: :slategray
  ] |> Stream.with_index |> Enum.each fn {{color, shade}, index} ->
      @index index

      def do_escape(text, unquote(color)) do
        "\e[1;#{30+@index}m#{text}\e[0m"
      end

      def do_escape(text, unquote(binary_to_atom("#{color}ish"))) do
        "\e[0;#{30+@index}m#{text}\e[0m"
      end
  end
end
