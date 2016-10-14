defmodule Apex.Format.Color do
  def color_key(data)
  def color_key(data) when is_binary(data),   do: {:ok, :binary}
  def color_key(data) when is_tuple(data),    do: {:ok, :tuple}
  def color_key(true),                        do: {:ok, true}
  def color_key(false),                       do: {:ok, false}
  def color_key(nil),                         do: {:ok, nil}
  def color_key(data) when is_atom(data),     do: {:ok, :atom}
  def color_key(data) when is_float(data),    do: {:ok, :float}
  def color_key(data) when is_integer(data),  do: {:ok, :integer}
  def color_key(data) when is_function(data), do: {:ok, :function}
  def color_key(data) when is_list(data),     do: {:ok, :list}
  def color_key(data) when is_pid(data),      do: {:ok, :pid}
  def color_key(data) when is_port(data),     do: {:ok, :port}
  def color_key({Range, _, _}),               do: {:ok, :range}
  def color_key({HashSet, _, _}),             do: {:ok, :hash_set}
  def color_key({HashDict, _, _}),            do: {:ok, :hash_dict}
  def color_key(_),                           do: :error

  def color_value(key)
  def color_value(:binary),    do: {:ok, :yellow}
  def color_value(:tuple),     do: {:ok, :blue}
  def color_value(:true),      do: {:ok, [:green, :bright]}
  def color_value(:false),     do: {:ok, [:red, :bright]}
  def color_value(:nil),       do: {:ok, :red}
  def color_value(:atom),      do: {:ok, :cyan}
  def color_value(:float),     do: {:ok, :blue}
  def color_value(:integer),   do: {:ok, :blue}
  def color_value(:function),  do: {:ok, :magenta}
  def color_value(:list),      do: {:ok, :white}
  def color_value(:pid),       do: {:ok, :yellow}
  def color_value(:port),      do: {:ok, [:green, :bright]}
  def color_value(:range),     do: {:ok, :green}
  def color_value(:hash_set),  do: {:ok, :white}
  def color_value(:hash_dict), do: {:ok, :white}
  def color_value(_),          do: :error

  defmacro __using__(_) do
    quote do
      def colorize(text, data, options \\ []) do
        cond do
          options[:color] == false   -> text
          {:ok, color} = color(data) -> escape(text, color)
          true                       -> text
        end
      end

      def escape(text, color) do
        IO.ANSI.format([color, text], true) |> IO.chardata_to_string
      end

      def color(data) do
        with {:ok, key} = unquote(__MODULE__).color_key(data) do
          unquote(__MODULE__).color_value(key)
        end
      end
    end
  end
end
