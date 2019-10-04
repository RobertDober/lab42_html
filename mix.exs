defmodule Lab42Html.MixProject do
  use Mix.Project

  @description "An isolated HTML generator. Inspired in its simplicity by Dave Thomas' keynote, condensed here https://pragdave.me/blog/2018/06/02/project-structure.html"
  @version "0.1.0"
  def project do
    [
      app: :lab42_html,
      deps: deps(),
      description: @description,
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env),
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: @version,
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:excoveralls, "~> 0.11.2", only: [:test]},
      {:extractly,   "~> 0.1.3", only: [:dev]}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp elixirc_paths(env)
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: [
        "lab42",
        "mix.exs",
        "README.md"
      ],
      maintainers: [
        "Robert Dober <robert.dober@gmail.com>"
      ],
      licenses: [
        "Apache 2 (see the file LICENSE for details)"
      ],
      links: %{
        "GitHub" => "https://github.com/robertdober/lab42_html"
      }
    ]
  end
end
