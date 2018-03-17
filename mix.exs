defmodule ExCompatible.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_compatible,
      version: "0.1.0",
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),

      # Docs
      name: "ExCompatible",
      source_url: "https://github.com/thecodeboss/ex_compatible",
      docs: [
        main: "Readme",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end

  defp description() do
    """
    ExCompatible strives to make your Elixir code compatible with as many Elixir
    versions as possible, while reducing the number of compiler warnings.
    """
  end

  defp package do
    [
      maintainers: ["Michael Oliver"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/thecodeboss/ex_compatible"}
    ]
  end
end
