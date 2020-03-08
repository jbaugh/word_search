defmodule WordSearch do
  @moduledoc """
  Documentation for `WordSearch`.
  """

  @doc """
  Generate a word search from a list of words.

  ## Examples

      iex> WordSearch.generate(["word", "another", "yetanother"], 15, "easy", "english")

  """
  def generate(words, _size, difficulty, language) do
    WordSearch.Alphabet.list(words, difficulty, language)
  end
end
