defmodule Folhacar.MixProject do
  use Mix.Project

  def project do
    [
      app: :folhacar,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :table_rex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.30.0"},
      {:table_rex, "~> 3.1.1"}
    ]
  end
end
