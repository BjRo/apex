defmodule AP.Mixfile do
  use Mix.Project

  def project do
    [ app: :ap,
      version: "0.0.1",
      elixir: "~> 0.12.2",
      deps: deps ]
  end

  def application do
    [mod: { AP, [] }]
  end

  defp deps do
    []
  end
end
