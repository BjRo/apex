defmodule AP do
  use Application.Behaviour

  def start(_type, _args) do
    AP.Supervisor.start_link
  end
end
