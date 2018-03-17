defmodule ExCompatible.MixProject do
  @moduledoc false
  use Mix.Project

  @description """
  ExCompatible strives to make your Elixir code compatible with as many Elixir
  versions as possible, while reducing the number of compiler warnings.
  """

  @version "0.1.0"
  @project_url "https://github.com/thecodeboss/ex_compatible"

  def project do
    [
      app: :ex_compatible,
      version: @version,
      elixir: "~> 1.1",
      deps: deps(),

      # URLs
      source_url: @project_url,
      homepage_url: @project_url,

      # Hex
      description: @description,
      package: package(),

      # Docs
      name: "ExCompatible",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],

      # Testing
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.8", only: :test, runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Michael Oliver"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url}
    ]
  end
end
