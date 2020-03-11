defmodule WordSearchTest do
  use ExUnit.Case

  test "generates the word search" do
    assert WordSearch.generate(["word", "war"], 5, "easy", ["forward", "diagonal"]) == :ok
  end
end
