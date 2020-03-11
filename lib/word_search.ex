defmodule WordSearch do
  @moduledoc """
  Documentation for `WordSearch`.
  """

  @doc """
  Generate a word search from a list of words.

  ## Examples

      iex> WordSearch.generate(["word", "another", "yetanother"], 10, "easy", ["forward", "diagonal"])

      V Y C A A A B N B I 
      Q K A Z N K C O G J 
      W I N X F T V D U I 
      V A O J E P J D K T 
      C U T J A G C N Z J 
      B X H G W O R D A I 
      J M E B I Z G F W G 
      F M R Y Q U S Y F X 
      S I Q X R J T P T T 
      G U I V S K R A W W 
  """
  def generate(words, size, difficulty, directions) do
    generate(words, size, difficulty, directions, "english")
  end
  def generate(words, size, difficulty, directions, language) do
    WordSearch.Alphabet.list(words, difficulty, language)
    |> WordSearch.WordSearch.build(words, size, directions)
  end
end
