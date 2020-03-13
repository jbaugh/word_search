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

  def to_list(state = %{size: size}) do
    new_grid = build_list(0, size * size, state[:grid], [])

    state
    |> Map.put(:grid, Enum.chunk_every(new_grid, size))
  end

  # Work from 0 to max_size - 1. When the num is equal to max_size, we are at the end
  defp build_list(max_size, max_size, _grid, list), do: list
  defp build_list(num, max_size, grid, list) do
    case Map.fetch(grid, num) do
      {:ok, val} -> build_list(num + 1, max_size, grid, list ++ [val])
      :error -> build_list(num + 1, max_size, grid, list)
    end
  end

  def display_grid(state = %{grid: grid, size: size}) do
    grid_size = size * size
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      if rem(num, size) == 0 do
        IO.puts ""
      end
      case Map.fetch(grid, num) do
        {:ok, letter} -> IO.write "#{letter} "
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
    put_in(state, [:grid, x + (y * state[:size])], List.to_string([letter]))
  end

  # Generates a list of possible positions to place
  defp generate_positions(side_size) do
    grid_size = side_size * side_size
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      {rem(num, side_size), div(num, side_size)}
    end)
  end
end
