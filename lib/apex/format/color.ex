defmodule Apex.Format.Color do
  defmodule StaticColors do
    def color(data)
    def color(data) when is_binary(data),   do: :yellow
    def color(data) when is_tuple(data),    do: :blue
    def color(true),                        do: [:green, :bright]
    def color(false),                       do: [:red, :bright]
    def color(nil),                         do: :red
    def color(data) when is_atom(data),     do: :cyan
    def color(data) when is_float(data),    do: :blue
    def color(data) when is_integer(data),  do: :blue
    def color(data) when is_function(data), do: :magenta
    def color(data) when is_list(data),     do: :white
    def color(data) when is_pid(data),      do: :yellow
    def color(data) when is_port(data),     do: [:green, :bright]
    def color({Range, _, _}),               do: :green
    def color({HashSet, _, _}),             do: :white
    def color({HashDict, _, _}),            do: :white
    def color(_), do: nil
  end

  defmacro __using__(_) do
    quote do
      def colorize(text, data, options \\ []) do
        cond do
          options[:color] == false -> text
          color = color(data)      -> escape(text, color)
          true                     -> text
        end
      end

      def escape(text, color) do
        IO.ANSI.format([color, text], true) |> IO.chardata_to_string
      end

      def color(data) do
        StaticColors.color(data)
      end
    end
  end
end
