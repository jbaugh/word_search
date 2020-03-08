defmodule WordSearch do
  @moduledoc """
  Documentation for `WordSearch`.
  """

  @doc """
  Generate a word search from a list of words.

  ## Examples

      iex> WordSearch.generate(["word", "another", "yetanother"], 15, "easy", ["forward", "backward", "diagonal"])

  """
  def generate(words, size, difficulty, directions) do
    generate(words, size, difficulty, directions, "english")
  end
  def generate(words, _size, difficulty, _directions, language) do
    WordSearch.Alphabet.list(words, difficulty, language)
  end
end
