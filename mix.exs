defmodule Lab42Html.MixProject do
  use Mix.Project

  @description "An isolated HTML generator. Inspired in its simplicity by Dave Thomas' keynote, condensed here https://pragdave.me/blog/2018/06/02/project-structure.html"
  @url "https://github.com/robertdober/lab42_html"
  @version "0.2.0"
  def project do
    [
      aliases: [docs: &build_docs/1],
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
      {:lab42_message, "~> 0.1.2"},
      {:dialyxir,    "~> 0.5.1", only: [:dev], optional: true, runtime: false},
      {:excoveralls, "~> 0.11.2", only: [:test]},
      {:extractly,   "~> 0.1.5", only: [:dev]}
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
        "lib",
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

  @prerequisites """
  run `mix escript.install hex ex_doc` and adjust `PATH` accordingly
  """
  defp build_docs(_) do
    Mix.Task.run("compile")
    ex_doc = Path.join(Mix.Local.path_for(:escript), "ex_doc")
    Mix.shell.info("Using escript: #{ex_doc} to build the docs")

    unless File.exists?(ex_doc) do
      raise "cannot build docs because escript for ex_doc is not installed, make sure to \n#{@prerequisites}"
    end

    args = ["Lab42.Html", @version, Mix.Project.compile_path()]
    opts = ~w[--main Lab42.Html --source-ref v#{@version} --source-url #{@url}]

    Mix.shell.info("Running: #{ex_doc} #{inspect(args ++ opts)}")
    System.cmd(ex_doc, args ++ opts)
    Mix.shell.info("Docs built successfully")
  end

end
