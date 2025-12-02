defmodule Day02Test do
  alias Aoc2025.Day02
  use ExUnit.Case, async: true

  defp test_data do
    "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
  end

  test "day02_part1" do
    assert Day02.solve(test_data(), :part1) == 1_227_775_554
  end

  test "day02_part2" do
    assert Day02.solve(test_data(), :part2) == 4_174_379_265
  end
end
