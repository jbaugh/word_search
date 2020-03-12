defmodule WordSearch.MixProject do
  use Mix.Project

  def project do
    [
      app: :word_search,
      version: "0.1.0",
      elixir: "~> 1.10",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "word_search",
      source_url: "https://github.com/jbaugh/word_search"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description() do
    "Generates a word search from a set of input words. The word search can be customized by size, word direction and 'difficulty'."
  end

  defp package() do
    [
      name: "word_search",
      # These are the default files included in the package
      files: ~w(lib test .formatter.exs mix.exs README* LICENSE CHANGELOG),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jbaugh/word_search"}
    ]
  end
end
