defmodule WordSearch.Directions do
  def convert(directions) do
    []
    |> convert_directions(directions, ["forward"], ["right", "down"])
    |> convert_directions(directions, ["backward"], ["left", "up"])
    |> convert_directions(directions, ["diagonal"], ["rightdown"])
    |> convert_directions(directions, ["backward", "diagonal"], ["leftup", "leftdown", "rightup"])
  end
  defp convert_directions(acc, input_dirs, check_dirs, add_dirs) do
    if Enum.all?(check_dirs, fn x -> x in input_dirs end) do
      acc ++ add_dirs
    else
      acc
    end
  end
end
