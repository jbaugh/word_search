defmodule WordSearch do
  @moduledoc """
  Documentation for `WordSearch`.
  """

  @doc """
  Generate a word search from a list of words.

  ## Examples

      iex> WordSearch.generate(["word", "another", "yetanother", "food", "red", "car", "treetop"], 10)

      Y T J H J O B T R G
      E E R E F U G C H D
      K Y T E K V J F V Q
      U V W A E F A H A Y
      F M I L N T N T Q C
      W O R D Q O O K X A
      A T L Q X W T P Q R
      F S H L G T H H H B
      B P V Y D O E F E Y
      D R E D L I R Z V R
  

      words - list of words to be used in the word search
      size - size of word search (a size of 10 will generate a 10x10 word search)
      difficulty - easy or hard. easy will use the entire alphabet for filling spaces, hard will only use characters from the input words
      directions - list of directions the words can be placed: forward, diagonal and backward. combining diagonal and backward will allow backward-diagonal words
      language - which character set to use. right now only english is supported, however words with special characters will be added to the alphabet for the word search 
  """
  def generate(words, size) do
    generate(words, size, "easy", ["forward", "diagonal"], "english")
  end
  def generate(words, size, directions) do
    generate(words, size, "easy", directions, "english")
  end
  def generate(words, size, difficulty, directions) do
    generate(words, size, difficulty, directions, "english")
  end
  def generate(words, size, difficulty, directions, language) do
    WordSearch.Alphabet.list(words, difficulty, language)
    |> WordSearch.Grid.build(words, size, directions)
  end
end
