defmodule WordSearch.Alphabet do
  def list(_words, "medium", language) do
    get_alphabet(language)
  end
  def list(_words, "hard", language) do
    get_alphabet(language)
  end
  # Easy and anything else
  def list(words, _difficulty, _language) do
    # get_alphabet(language)
    get_characters_in_words(words)
  end

  # Default is english
  defp get_alphabet(_language) do
    WordSearch.Alphabet.BasicLatin.chars
  end

  
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
