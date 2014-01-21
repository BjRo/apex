defmodule Apex.Format.Color do
  def colorize(text, data) do
    if color = color(data) do
      escape(text, color)
    else
      text
    end
  end

  def escape(text, color), do: do_escape(text, color)

  defp color(data) when is_binary(data),   do: :yellowish
  defp color(data) when is_atom(data),     do: :cyanish
  defp color(data) when is_float(data),    do: :blue
  defp color(data) when is_integer(data),  do: :blue
  defp color(data) when is_function(data), do: :purpleish
  defp color(data) when is_list(data),     do: :white
  defp color({Range, _, _}),               do: :greenish
  defp color({HashSet, _, _}),             do: :whiteish
  defp color({HashDict, _, _}),            do: :whiteish
  defp color(nil),                         do: :red
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
