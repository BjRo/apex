defmodule Apex do
  @moduledoc "Elixir clone of the awesome_print gem"

  @doc """
    Pretty prints the supplied data
  """
  def ap(data, options \\ []) do
    IO.puts(Apex.Format.format(data, options))
  end
end
