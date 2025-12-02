defmodule Day01Test do
  alias Aoc2025.Day01
  use ExUnit.Case, async: true

  defp test_data do
    "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"
  end

  test "day01_part1" do
    assert Day01.solve(test_data(), :part1) == {3, 32}
  end

  test "day01_part2" do
    assert Day01.solve(test_data(), :part2) == {6, 32}
  end
end
