defmodule WordSearch.Grid do
  def fill_words(words, size, directions) do
    state = %{
      words: words,
      grid: %{}, # 1d "array"
      size: size * size, # grid will be a 1d "array", so square the size
      available_positions: generate_positions(size * size),
      directions: WordSearch.Directions.convert(directions)
    }
    place_words(state)
    :ok
  end

  defp place_words(state = %{words: []}), do: state
  defp place_words(state = %{words: [word|words], size: size, available_positions: available_positions, grid: grid, directions: [dir|directions]}) do
    place_word(state, word, dir)
    %{
      words: words,
      grid: grid,
      size: size,
      available_positions: available_positions,
      directions: directions ++ [dir] # Cycle the directions
    } |> place_words
  end

  defp spot_available?(state, x, y) do
    !Map.has_key?(state[:grid], x + (y * state[:size]))
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
    if spot_available?(state, x, y) do
      IO.puts "Trying word " <> word <> " going " <> direction <> " at (" <> Integer.to_string(x) <> ", " <> Integer.to_string(y) <> ")"
    else
      place_word(state, word, direction, positions)
    end
  end

  defp generate_positions(grid_size) do
    side_size = round(:math.sqrt(grid_size))
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      {rem(num, side_size), div(num, side_size)}
    end)
  end
end
