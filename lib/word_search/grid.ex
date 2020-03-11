defmodule WordSearch.Grid do
  def build(alpahbet, words, size, directions) do
    WordSearch.State.new(alpahbet, words, size, directions)
    |> place_words
    |> fill_unclaimed_spaces
  end

  # Place random letters in any unfilled spots on grid
  defp fill_unclaimed_spaces(state = %{size: size}) do
    grid_size = size * size
    fill_unclaimed_spaces(state, grid_size - 1)
  end
  defp fill_unclaimed_spaces(state, -1), do: state
  defp fill_unclaimed_spaces(state, pos) do
    case Map.fetch(state[:grid], pos) do
        {:ok, _} -> fill_unclaimed_spaces(state, pos - 1)
        :error ->
          put_in(state, [:grid, pos], Enum.take_random(state[:alpahbet], 1))
          |> fill_unclaimed_spaces(pos - 1)
      end
  end

  # GO through words and try to place them
  defp place_words(state = %{words: []}), do: state
  defp place_words(state = %{words: [word|words], directions: [dir|directions]}) do
    %{
      words: words,
      grid: attempt_to_place_word(state, String.upcase(word), dir)[:grid],
      size: state[:size],
      available_positions: state[:available_positions],
      directions: directions ++ [dir], # Cycle the directions
      alpahbet: state[:alpahbet]
    }
    |> place_words
  end

  # A "wrapper" method for attempt_to_place_word/4
  defp attempt_to_place_word(state, word, direction) do
    # Shuffle positions so that it doesn't keep trying in one specific area
    positions = Enum.shuffle(state[:available_positions])
    # If direction is 'backwards', make it 'forwards' and reverse word
    {word_to_place, direction_to_place} = WordSearch.Directions.orient_word_and_direction(word, direction)
    attempt_to_place_word(state, word_to_place, direction_to_place, positions)
  end

  # Checks if the word can fit in the given coords/direction. If it cannot be placed,
  # it checks the next set of coords.
  defp attempt_to_place_word(state, word, _direction, []) do
    IO.puts "Could not place word - #{word}"
    state
  end
  defp attempt_to_place_word(state, word, direction, [position|positions]) do
    {x, y} = position
    if can_place_word?(state, word, direction, x, y) do
      # IO.puts " => true"
      place_word(state, word, direction, x, y)
    else
      attempt_to_place_word(state, word, direction, positions)
    end
  end

  # Places the word starting at the point x,y oriented with direction
  # Note: this does not check for validity
  defp place_word(state, word, direction, x, y) do
    _place_word(state, to_charlist(word), direction, x, y)
  end
  defp _place_word(state, [], _direction, _x, _y) do
    state
  end
  defp _place_word(state, [letter|word], direction, x, y) do
    {nx, ny} = WordSearch.Directions.next_x_y(x, y, direction)
    WordSearch.State.set_letter(state, x, y, letter)
    |> _place_word(word, direction, nx, ny)
  end

  # Checks if the word can be placed starting at the point x,y oriented with direction
  #
  # Goes through each letter in the word, and checks if the spot is either empty, or already
  # filled with that letter. As soon as one letter cannot be placed, it returns false
  defp can_place_word?(state, word, direction, x, y) do
    # IO.puts "Trying word '" <> word <> "' going " <> direction <> " at (" <> Integer.to_string(x) <> ", " <> Integer.to_string(y) <> ")"
    _can_place_word?(state, to_charlist(word), direction, x, y)
  end
  defp _can_place_word?(_state, [], _direction, _x, _y), do: true
  defp _can_place_word?(state, [letter|word], direction, x, y) do
    case WordSearch.State.spot_available?(state, x, y, letter) do
      true ->
        {nx, ny} = WordSearch.Directions.next_x_y(x, y, direction)
        _can_place_word?(state, word, direction, nx, ny)
      false -> false
    end
  end
end
