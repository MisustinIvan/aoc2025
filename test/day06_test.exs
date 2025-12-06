defmodule Day06Test do
  alias Aoc2025.Day06
  use ExUnit.Case, async: true

  defp test_data do
    "123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  "
  end

  test "day06_part1" do
    assert Day06.solve(test_data(), :part1) == 4_277_556
  end

  test "day06_part2" do
    assert Day06.solve(test_data(), :part2) == 3_263_827
  end
end
