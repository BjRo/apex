defmodule AP do
  use Application.Behaviour

  def start(_type, _args) do
    AP.Supervisor.start_link
  end

  def ap(data, options // []) do
    IO.puts AP.Format.format(data, options)
  end
end
