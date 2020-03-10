defmodule WordSearch.Grid do
  def fill_words(words, size, directions) do
    state = %{
      words: words,
      grid: %{}, # 1d "array"
      size: size, # size of one side
      available_positions: generate_positions(size),
      directions: WordSearch.Directions.convert(directions)
    }
    place_words(state)
    |> display_grid
    :ok
  end

  defp display_grid(%{size: size, grid: grid}) do
    grid_size = size * size
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      if rem(num, size) == 0 do
        IO.puts ""
      end

      case Map.fetch(grid, num) do
        {:ok, letter} -> IO.write "#{List.to_string([letter])} "
        :error -> IO.write "  "
      end
    end)
  end

  defp place_words(state = %{words: []}), do: state
  defp place_words(state = %{words: [word|words], directions: [dir|directions]}) do
    %{
      words: words,
      grid: place_word(state, word, dir)[:grid],
      size: state[:size],
      available_positions: state[:available_positions],
      directions: directions ++ [dir] # Cycle the directions
    } |> place_words
  end

  defp spot_available?(%{size: size}, x, _y, _letter) when x >= size, do: false
  defp spot_available?(%{size: size}, _x, y, _letter) when y >= size, do: false
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
    set_spot(state, x, y, letter)
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
    case spot_available?(state, x, y, letter) do
      true ->
        {nx, ny} = WordSearch.Directions.next_x_y(x, y, direction)
        _can_place_word?(state, word, direction, nx, ny)
      false -> false
    end
  end

  defp generate_positions(side_size) do
    grid_size = side_size * side_size
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      {rem(num, side_size), div(num, side_size)}
    end)
  end
end
