defmodule AP do
  use Application.Behaviour

  def start(_type, _args) do
    AP.Supervisor.start_link
  end

  def ap(data, options // []) do
    AP.Printer.print(data, options)
  end
end
