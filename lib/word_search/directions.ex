defmodule WordSearch.Directions do
  # Gets next x,y based on the direction
  def next_x_y(x, y, "right"), do: {x + 1, y}
  def next_x_y(x, y, "down"), do: {x, y + 1}
  def next_x_y(x, y, "rightdown"), do: {x + 1, y + 1}
  def next_x_y(x, y, "rightup"), do: {x + 1, y - 1}

  # Reverses the word and direction if the original direction is "backward"
  # This makes it easier for placement, since everything is "forward"
  def orient_word_and_direction(word, "left") do
    {String.reverse(word), "right"}
  end
  def orient_word_and_direction(word, "up") do
    {String.reverse(word), "down"}
  end
  def orient_word_and_direction(word, "leftup") do
    {String.reverse(word), "rightdown"}
  end
  def orient_word_and_direction(word, "leftdown") do
    {String.reverse(word), "rightup"}
  end
  def orient_word_and_direction(word, direction) do
    {word, direction}
  end

  # Convert the main direction to the possible directions
  def convert(directions) do
    []
    |> convert_directions(directions, ["forward"], ["right", "down"])
    |> convert_directions(directions, ["backward"], ["left", "up"])
    |> convert_directions(directions, ["diagonal"], ["rightdown", "rightup"])
    |> convert_directions(directions, ["backward", "diagonal"], ["leftup", "leftdown"])
  end
  defp convert_directions(acc, input_dirs, check_dirs, add_dirs) do
    if Enum.all?(check_dirs, fn x -> x in input_dirs end) do
      acc ++ add_dirs
    else
      acc
    end
  end
end
