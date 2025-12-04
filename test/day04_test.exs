defmodule Day04Test do
  alias Aoc2025.Day04
  use ExUnit.Case, async: true

  defp test_data do
    "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"
  end

  test "day04_part1" do
    assert Day04.solve(test_data(), :part1) == 13
  end

  test "day04_part2" do
    assert Day04.solve(test_data(), :part2) == 43
  end
end
