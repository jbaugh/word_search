defmodule WordSearch do
  @moduledoc """
  Generate a word search with various options.

  ## Examples

      iex> WordSearch.generate(["word", "another", "yetanother", "food", "red", "car", "treetop"], 10)

      [
        ["R", "A", "T", "F", "K", "Y", "K", "V", "K", "R"],
        ["Q", "N", "B", "I", "H", "M", "T", "C", "E", "G"],
        ["D", "O", "G", "W", "O", "R", "D", "H", "F", "N"],
        ["T", "T", "C", "A", "G", "D", "T", "A", "U", "H"], 
        ["I", "H", "A", "F", "O", "O", "A", "K", "G", "Z"],
        ["N", "E", "R", "O", "N", "A", "L", "P", "B", "M"],
        ["P", "R", "F", "A", "W", "R", "E", "D", "K", "G"],
        ["R", "G", "T", "E", "J", "M", "R", "Q", "P", "I"],
        ["X", "E", "E", "S", "S", "E", "C", "T", "Z", "D"],
        ["Y", "S", "D", "L", "Q", "Y", "K", "R", "J", "F"]
      ]


  ## Parameters
      
      words - list of words to be used in the word search
      size - size of word search (a size of 10 will generate a 10x10 word search)
      difficulty - easy or hard. easy will use the entire alphabet for filling spaces, hard will only use characters from the input words
      directions - list of directions the words can be placed: forward, diagonal and backward. combining diagonal and backward will allow backward-diagonal words
      language - which character set to use. right now only english is supported, however words with special characters will be added to the alphabet for the word search 

  """

  @doc """
  Generate a word search from a list of words, with directions, difficulty and language set to a default.
  
      directions will be set to ["forward", "diagonal"]
      difficulty will be set to "easy"
      language will be set to "english"
  """
  def generate(words, size) do
    generate(words, size, ["forward", "diagonal"], "easy", "english")
  end

  @doc """
  Generate a word search from a list of words, with difficulty and language set to a default.
  
      difficulty will be set to "easy"
      language will be set to "english"
  """
  def generate(words, size, directions) do
    generate(words, size, directions, "easy", "english")
  end

  @doc """
  Generate a word search from a list of words, with language set to a default.
  
      language will be set to "english"
  """
  def generate(words, size, directions, difficulty) do
    generate(words, size, directions, difficulty, "english")
  end

  @doc """
  Generate a word search from a list of words.
  """
  def generate(words, size, directions, difficulty, language) do
    WordSearch.Alphabet.list(words, difficulty, language)
    |> WordSearch.Grid.build(words, size, directions)
    |> Map.fetch!(:grid)
  end
end
