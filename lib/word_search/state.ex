defmodule WordSearch.State do
  def new(alpahbet, words, size, directions) do
    %{
      alpahbet: alpahbet,
      words: words,
      grid: %{}, # 1d "array"
      size: size, # size of one side
      available_positions: generate_positions(size),
      directions: WordSearch.Directions.convert(directions)
    }
  end

  def fill_unclaimed_spaces(%{size: size, grid: grid, alpahbet: alpahbet}) do
    grid_size = size * size
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      case Map.fetch(grid, num) do
        {:ok, letter} -> letter
        :error -> Enum.take_random(alpahbet, 1)
      end
    end)
  end

  def display_grid(grid) do
    Enum.map(Enum.with_index(grid), fn {letter, index} ->
      if rem(index, 10) == 0 do
        IO.puts ""
      end
      IO.write "#{List.to_string([letter])} "
    end)
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

  defp generate_positions(side_size) do
    grid_size = side_size * side_size
    Enum.map(Enum.to_list(0..(grid_size - 1)), fn num ->
      {rem(num, side_size), div(num, side_size)}
    end)
  end
end
