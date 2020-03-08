defmodule WordSearch.Alphabet do
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
