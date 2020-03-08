defmodule WordSearch.Grid do
  def fill_words(words, size, directions) do
    state = %{
      grid: %{},
      directions: WordSearch.Directions.convert(directions)
    }
    state
  end
end
