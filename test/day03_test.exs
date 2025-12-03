defmodule Day03Test do
  alias Aoc2025.Day03
  use ExUnit.Case, async: true

  defp test_data do
    "987654321111111
811111111111119
234234234234278
818181911112111"
  end

  test "day03_part1" do
    assert Day03.solve(test_data(), :part1) == 357
  end

  test "day03_part2" do
    assert Day03.solve(test_data(), :part2) == 3_121_910_778_619
  end
end
