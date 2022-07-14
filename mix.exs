defmodule Johnson.MixProject do
  use Mix.Project

  def project do
    [
      app: :johnson,
      version: "1.0.0",
      elixir: "~> 1.12",
      build_permanent: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      aliases: aliases(),
      name: "Johnson",
      source_url: "https://github.com/ukchukx/johnson"
    ]
  end

  defp description do
    """
    Encode and decode JSON without altering the key order.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Uk Chukundah"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ukchukx/johnson",
               "Docs"   => "https://hexdocs.pm/johnson"
              }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 0.5.1", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.28.4", only: :dev},
      {:jason, "~> 1.3"}
    ]
  end

  defp aliases do
    [
      compile: ["compile --docs"]
    ]
  end
end
