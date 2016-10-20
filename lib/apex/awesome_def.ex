defmodule Apex.AwesomeDef do
  import Apex.Format.Utils

  defmacro adef(head, body) do
    {fun_name, args_ast} = name_and_args(head)
    {arg_names, decorated_args} = decorate_args(args_ast)
    head = replace_args_with_decorated_args(head, fun_name, args_ast, decorated_args)

    quote do
      def unquote(head) do
        ap_file = __ENV__.file
        ap_line = __ENV__.line
        ap_module = __ENV__.module
        ap_function_name = unquote(fun_name)
        ap_result = unquote(body[:do])

        IO.puts separator_line(">")
        IO.puts "Function " <> escape("#{ap_module}.#{ap_function_name}", :cyan) <> " was called"
        IO.puts "defined in " <> escape("#{ap_file}:#{ap_line}", :cyan)
        IO.puts separator_line("-")
        IO.puts "Parameters:"
        IO.puts separator_line("-")
        Apex.ap unquote(arg_names)
        IO.puts separator_line("-")
        IO.puts "Result:"
        IO.puts separator_line("-")
        Apex.ap ap_result

        ap_result
      end
    end
  end

  defp replace_args_with_decorated_args(head, fun_name, args_ast, decorated_args) do
    Macro.postwalk(head, fn(node) ->
      case node do
        {fun_ast, context, old_args} when (fun_ast == fun_name and old_args == args_ast) ->
          {fun_ast, context, decorated_args}
        other -> other
      end
    end)
  end

  defp name_and_args({:when, _, [short_head | _]}), do: name_and_args(short_head)
  defp name_and_args(short_head), do: Macro.decompose_call(short_head)

  defp decorate_args([]), do: {[],[]}
  defp decorate_args(args_ast) do
    Enum.with_index(args_ast)
      |> Enum.map(&decorate_arg/1)
      |> Enum.unzip
  end

  defp decorate_arg({arg_ast, index}) do
    if elem(arg_ast, 0) == :\\  do
      {:\\, _, [{optional_name, _, _}, _]} = arg_ast
      { Macro.var(optional_name, nil), arg_ast}
    else
      arg_name = Macro.var(:"arg#{index}", __MODULE__)

      full_arg = quote do
        unquote(arg_ast) = unquote(arg_name)
      end

      {arg_name, full_arg}
    end
  end
end
