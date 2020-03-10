defmodule WordSearch.DirectionsTest do
  use ExUnit.Case

  test "reverses word and sets new direction for left" do
    assert WordSearch.Directions.orient_word_and_direction("word", "left") == {"drow", "right"}
  end
  test "reverses word and sets new direction for up" do
    assert WordSearch.Directions.orient_word_and_direction("word", "up") == {"drow", "down"}
  end
  test "reverses word and sets new direction for leftup" do
    assert WordSearch.Directions.orient_word_and_direction("word", "leftup") == {"drow", "rightdown"}
  end
  test "reverses word and sets new direction for leftdown" do
    assert WordSearch.Directions.orient_word_and_direction("word", "leftdown") == {"drow", "rightup"}
  end
  test "returns word and direction for anything else" do
    assert WordSearch.Directions.orient_word_and_direction("word", "right") == {"word", "right"}
    assert WordSearch.Directions.orient_word_and_direction("word", "down") == {"word", "down"}
    assert WordSearch.Directions.orient_word_and_direction("word", "rightdown") == {"word", "rightdown"}
    assert WordSearch.Directions.orient_word_and_direction("word", "rightup") == {"word", "rightup"}
    assert WordSearch.Directions.orient_word_and_direction("word", "fooby") == {"word", "fooby"}
  end

  test "converts forward input to placement directions" do
    assert WordSearch.Directions.convert(["forward"]) == ["right", "down"]
  end
  test "converts backward input to placement directions" do
    assert WordSearch.Directions.convert(["backward"]) == ["left", "up"]
  end
  test "converts diagonal input to placement directions" do
    assert WordSearch.Directions.convert(["diagonal"]) == ["rightdown", "rightup"]
  end
  test "converts backward and diagonal input to placement directions" do
    assert WordSearch.Directions.convert(["backward", "diagonal"]) == ["left", "up", "rightdown", "rightup", "leftup", "leftdown"]
  end
  test "converts input for all to placement directions" do
    assert WordSearch.Directions.convert(["forward", "backward", "diagonal"]) == ["right", "down", "left", "up", "rightdown", "rightup", "leftup", "leftdown"]
  end
end
