defmodule Apex do
  def ap(data, options // []) do
    IO.puts(Apex.Format.format(data, options))
  end
end
