defmodule TextAnalyzer.MixProject do
  use Mix.Project

  def project do
    [
      app: :text_analyzer,
      version: "0.1.0",
      elixir: "~> 1.18",
      erlang: "27.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {TextAnalyzer.Application, []}
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.7.0-rc.0", override: true},
      {:phoenix_pubsub, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:plug, "~> 1.14"},
      {:uuid, "~> 1.1"},
      {:vex, "~> 0.8.0"},
      {:plug_cowboy, "~> 2.6"}
    ]
  end
end
