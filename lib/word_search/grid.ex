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
    |> display_grid
    :ok
  end

  defp display_grid(state) do
    IO.puts inspect state[:grid]
  end

  defp place_words(state = %{words: []}), do: state
  defp place_words(state = %{words: [word|words], size: size, available_positions: available_positions, directions: [dir|directions]}) do
    %{
      words: words,
      grid: place_word(state, word, dir)[:grid],
      size: size,
      available_positions: available_positions,
      directions: directions ++ [dir] # Cycle the directions
    } |> place_words
  end

  defp spot_available?(state, x, y, letter) do
    case Map.fetch(state[:grid], x + (y * state[:size])) do
      {:ok, val} -> 
        if val == letter do
          true
        else
          false
        end
      :error -> true
    end
  end

  defp set_spot(state, x, y, letter) do
    # Map.put(state[:grid], x + (y * state[:size], letter)
    put_in(state, [:grid, x + (y * state[:size])], letter)
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
      IO.puts "Can place word!"
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
    set_spot(state, letter, x, y)
    |> _insert_word(word, direction, nx, ny)
  end

  defp can_place_word?(state, word, direction, x, y) do
    IO.puts "Trying word '" <> word <> "' going " <> direction <> " at (" <> Integer.to_string(x) <> ", " <> Integer.to_string(y) <> ")"
    _can_place_word?(state, to_charlist(word), direction, x, y)
  end
  defp _can_place_word?(_state, [], _direction, _x, _y) do
    true
  end
  defp _can_place_word?(state, [letter|word], direction, x, y) do
    case spot_available?(state, letter, x, y) do
      true ->
        {nx, ny} = WordSearch.Directions.next_x_y(x, y, direction)
        _can_place_word?(state, word, direction, nx, ny)
      false -> false
    end
  end

  defp generate_positions(grid_size) do
    side_size = round(:math.sqrt(grid_size))
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      {rem(num, side_size), div(num, side_size)}
    end)
  end
end
