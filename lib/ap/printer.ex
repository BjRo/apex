defmodule AP.Printer do
  use GenServer.Behaviour
  import AP.Format

  def start_link(args // [], opts // []) do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, args, opts)
  end

  def print(data, opts) do
    :gen_server.cast(__MODULE__, {:print, data, opts})
  end

  def init(_), do: { :ok, [] }

  def handle_cast({:print, data, opts}, state) do
    format(data, opts) |> IO.puts
    { :noreply, state }
  end
end
