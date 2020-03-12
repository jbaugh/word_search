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

The package can be installed by adding `word_search` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:word_search, "~> 0.1.0"}
  ]
end
```

Documentation can be found on [HexDocs](https://hexdocs.pm/word_search/0.1.0).

