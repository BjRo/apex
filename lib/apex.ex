defmodule Apex do
  @moduledoc "Elixir clone of the awesome_print gem"

  @doc """
    Pretty prints the supplied data and returns the original data.
  """
  def ap(data, options \\ []) do
    formatted = Apex.Format.format(data, options)
    case Keyword.get(options, :label) do
      nil -> IO.puts(formatted)
      label -> IO.puts(label <> ": " <> formatted)
    end
    data
  end
end
