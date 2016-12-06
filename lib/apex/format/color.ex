defmodule Apex.Format.Color do
  def id(data)
  def id(data) when is_binary(data),            do: {:ok, :binary}
  def id(data) when is_tuple(data),             do: {:ok, :tuple}
  def id(data) when data in [true, false, nil], do: {:ok, data}
  def id(data) when is_atom(data),              do: {:ok, :atom}
  def id(data) when is_float(data),             do: {:ok, :float}
  def id(data) when is_integer(data),           do: {:ok, :integer}
  def id(data) when is_function(data),          do: {:ok, :function}
  def id(data) when is_list(data),              do: {:ok, :list}
  def id(data) when is_pid(data),               do: {:ok, :pid}
  def id(data) when is_port(data),              do: {:ok, :port}
  def id({Range, _, _}),                        do: {:ok, :range}
  def id({HashSet, _, _}),                      do: {:ok, :hash_set}
  def id({HashDict, _, _}),                     do: {:ok, :hash_dict}
  def id(_),                                    do: :unknown

  @default_colors %{
    binary:    :yellow,
    tuple:     :blue,
    true:      [:green, :bright],
    false:     [:red, :bright],
    nil:       :red,
    atom:      :cyan,
    float:     :blue,
    integer:   :blue,
    function:  :magenta,
    list:      :white,
    pid:       :yellow,
    port:      [:green, :bright],
    range:     :green,
    hash_set:  :white,
    hash_dict: :white
  }

  def default_colors do
    @default_colors
  end

  def default_color(id) do
    Map.get(default_colors(), id)
  end

  def customization_file do
    Path.expand("~/.apexrc")
  end

  def load_color_customizations_from_apexrc do
    with {:ok, contents }        <- File.read(customization_file()),
         {%{colors: colors}, _}  when is_map(colors) <- Code.eval_string(contents, [], __ENV__) do
           colors
         else
           _ -> %{}
         end
  end

  defmacro __using__(_) do
    user_defined_colors_from_apexrc = __MODULE__.load_color_customizations_from_apexrc

    quote do
      import unquote(__MODULE__)

      def colorize(text, data, opts \\ []) do
        data
          |> id
          |> do_colorize(text, opts[:color])
      end

      def escape(text, color) do
        [color, text]
          |> IO.ANSI.format(true)
          |> IO.chardata_to_string
      end

      defp do_colorize(id, text, should_color)
      defp do_colorize(_id, text, false),  do: text
      defp do_colorize(:unknown, text, _), do: text
      defp do_colorize({:ok, id}, text, _) do
        color = user_defined_color_app_config(id) || user_defined_color_apexrc(id) || default_color(id)
        escape(text, color)
      end

      @user_defined_colors_from_apexrc unquote(Macro.escape(user_defined_colors_from_apexrc))
      defp user_defined_color_apexrc(id) do
        Map.get(@user_defined_colors_from_apexrc, id)
      end

      defp user_defined_color_app_config(id) do
        :apex
          |> Application.get_env(:colors, %{})
          |> Map.get(id)
      end
    end
  end
end
