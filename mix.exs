defmodule Apex.Mixfile do
  use Mix.Project

  def project do
    [ app: :apex,
      version: "0.3.5",
      elixir: "~> 1.2.0",
      build_per_environment: false,
      description: description,
      package: package,
      deps: deps ]
  end

  def application do
    []
  end

  defp deps do
    []
  end

  def description do
    "Elixir clone of Ruby's awesome_print gem"
  end

  def package do
    [
      maintainers: ["Bjoern Rochel"],
      licenses: ["The MIT License"],
      links: %{
        "GitHub" => "https://github.com/bjro/apex"
      }
    ]
  end
end
