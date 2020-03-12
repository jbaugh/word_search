# WordSearch

Generates a word search with various input options.

## How to Use

```elixir
WordSearch.generate(word_list, size)
WordSearch.generate(word_list, size, directions)
WordSearch.generate(word_list, size, directions, difficulty)
```

## Options
- word_list (example: ["car", "food", "tree"])
- size (the size of the word search. a size of 10 will create a 10x10 grid)
- directions (list of directions, possible values: ["forward", "backward", "diagonal"])
- difficulty (possible values: ["easy", "hard"] "easy" will use entire alphabet, "hard" will just use the letters in the words)


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `word_search` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:word_search, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/word_search](https://hexdocs.pm/word_search).

