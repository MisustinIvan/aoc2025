defmodule Day05Test do
  alias Aoc2025.Day05
  use ExUnit.Case, async: true

  defp test_data do
    "3-5
10-14
16-20
12-18

1
5
8
11
17
32"
  end

  test "day05_part1" do
    assert Day05.solve(test_data(), :part1) == 3
  end

  test "day05_part2" do
    assert Day05.solve(test_data(), :part2) == 14
  end
end
