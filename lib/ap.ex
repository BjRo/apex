defmodule AP do
  def ap(data, options // []) do
    IO.puts(AP.Format.format(data, options))
  end
end
