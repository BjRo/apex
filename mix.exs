defmodule Apex.Mixfile do
  use Mix.Project

  def project do
    [ app: :apex,
      version: "0.0.2",
      elixir: "~> 0.12.3",
      deps: deps ]
  end

  def application do
    []
  end

  defp deps do
    []
  end
end
