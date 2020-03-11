defmodule WordSearch.WordSearch do
  def build(alpahbet, words, size, directions) do
    WordSearch.State.new(alpahbet, words, size, directions)
    |> place_words
    |> WordSearch.State.fill_unclaimed_spaces
    |> WordSearch.State.display_grid
    :ok
  end

  defp place_words(state = %{words: []}), do: state
  defp place_words(state = %{words: [word|words], directions: [dir|directions]}) do
    %{
      words: words,
      grid: place_word(state, String.upcase(word), dir)[:grid],
      size: state[:size],
      available_positions: state[:available_positions],
      directions: directions ++ [dir], # Cycle the directions
      alpahbet: state[:alpahbet]
    } |> place_words
  end

  defp place_word(state, word, direction) do
    positions = Enum.shuffle(state[:available_positions])
    # If direction is 'backwards', make it 'forwards' and reverse word
    {word_to_place, direction_to_place} = WordSearch.Directions.orient_word_and_direction(word, direction)
    place_word(state, word_to_place, direction_to_place, positions)
  end

  # available positions is for some reason matching with []
  # defp place_word(state, _word, _direction, []), do: state
  defp place_word(state, _word, _direction, []) do
    state
  end
  defp place_word(state, word, direction, [position|positions]) do
    {x, y} = position
    if can_place_word?(state, word, direction, x, y) do
      # IO.puts " => true"
      insert_word(state, word, direction, x, y)
    else
      place_word(state, word, direction, positions)
    end
  end

  defp insert_word(state, word, direction, x, y) do
    _insert_word(state, to_charlist(word), direction, x, y)
  end
  defp _insert_word(state, [], _direction, _x, _y) do
    state
  end
  defp _insert_word(state, [letter|word], direction, x, y) do
    {nx, ny} = WordSearch.Directions.next_x_y(x, y, direction)
    WordSearch.State.set_letter(state, x, y, letter)
    |> _insert_word(word, direction, nx, ny)
  end

  defp can_place_word?(state, word, direction, x, y) do
    # IO.puts "Trying word '" <> word <> "' going " <> direction <> " at (" <> Integer.to_string(x) <> ", " <> Integer.to_string(y) <> ")"
    _can_place_word?(state, to_charlist(word), direction, x, y)
  end
  defp _can_place_word?(_state, [], _direction, _x, _y) do
    true
  end
  defp _can_place_word?(state, [letter|word], direction, x, y) do
    case WordSearch.State.spot_available?(state, x, y, letter) do
      true ->
        {nx, ny} = WordSearch.Directions.next_x_y(x, y, direction)
        _can_place_word?(state, word, direction, nx, ny)
      false -> false
    end
  end
end
