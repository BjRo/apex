defmodule Apex.Mixfile do
  use Mix.Project

  def project do
    [ app: :apex,
      version: "0.7.0",
      elixir: "~> 1.2 or ~> 1.3",
      build_per_environment: false,
      description: description(),
      package: package(),
      deps: deps()]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
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
