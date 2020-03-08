defmodule WordSearch.DirectionsTest do
  use ExUnit.Case

  test "converts forward input to placement directions" do
    assert WordSearch.Directions.convert(["forward"]) == ["right", "down"]
  end
  test "converts backward input to placement directions" do
    assert WordSearch.Directions.convert(["backward"]) == ["left", "up"]
  end
  test "converts diagonal input to placement directions" do
    assert WordSearch.Directions.convert(["diagonal"]) == ["rightdown"]
  end
  test "converts backward and diagonal input to placement directions" do
    assert WordSearch.Directions.convert(["backward", "diagonal"]) == ["left", "up", "rightdown", "leftup", "leftdown", "rightup"]
  end
  test "converts input for all to placement directions" do
    assert WordSearch.Directions.convert(["forward", "backward", "diagonal"]) == ["right", "down", "left", "up", "rightdown", "leftup", "leftdown", "rightup"]
  end
end
