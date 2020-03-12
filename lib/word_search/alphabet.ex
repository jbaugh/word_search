defmodule WordSearch.Alphabet do
  @moduledoc """
  The list of characters to be used in the word search. For any case, the characters used in the input words will be used in the alphabet. For "easy" difficulty, the full alphabet will be used. Special characters will only be included if the input words contain them.
  """

  @doc """
  Return a list of characters to be used based on the input words, difficulty and language
  """
  # Only use characters within the word set
  def list(words, "hard", _language) do
    get_characters_in_words(words)
  end
  # Use the standard alphabet and whatever special characters in the input words (for example accents, umlaut, etc)
  def list(words, _difficulty, language) do
    Enum.uniq(get_characters_in_words(words) ++ get_alphabet(language))
  end

  # Default is english
  defp get_alphabet(_language) do
    WordSearch.Alphabet.BasicLatin.chars
  end

  # Get a capitalized, unique list of characters used in all words
  defp get_characters_in_words(words), do: get_characters_in_words(words, [])
  defp get_characters_in_words([], char_list) do 
    Enum.uniq(char_list)
  end
  defp get_characters_in_words([head|words], char_list) do
    get_characters_in_words(words, get_characters_in_word(head) ++ char_list)
  end

  defp get_characters_in_word(word) do
    word
    |> String.upcase
    |> to_charlist
  end
end
