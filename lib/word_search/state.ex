defmodule WordSearch.State do
  def new(alpahbet, words, size, directions) do
    %{
      alpahbet: alpahbet,
      words: words,
      placed_words: [],
      grid: %{}, # 1d "array"
      size: size, # size of one side
      available_positions: generate_positions(size),
      directions: WordSearch.Directions.convert(directions)
    }
  end

  def display_grid(state = %{grid: grid, size: size}) do
    grid_size = size * size
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      if rem(num, size) == 0 do
        IO.puts ""
      end
      case Map.fetch(grid, num) do
        {:ok, letter} -> IO.write "#{List.to_string([letter])} "
        :error -> :ok
      end
    end)
    state
  end

  def spot_available?(%{size: size}, x, _y, _letter) when x >= size, do: false
  def spot_available?(%{size: size}, _x, y, _letter) when y >= size, do: false
  def spot_available?(state, x, y, letter) do
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

  def set_letter(state, x, y, letter) do
    put_in(state, [:grid, x + (y * state[:size])], letter)
  end

  # Generates a list of possible positions to place
  defp generate_positions(side_size) do
    grid_size = side_size * side_size
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      {rem(num, side_size), div(num, side_size)}
    end)
  end
end
