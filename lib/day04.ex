defmodule Aoc2025.Day04 do
  @spec parse_input(String.t()) :: %{{integer, integer} => String.t()}
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, x}, line_acc ->
        Map.put(line_acc, {x, y}, char)
      end)
    end)
  end

  defp neighbors({x, y}) do
    [
      {x - 1, y - 1},
      {x + 1, y + 1},
      {x - 1, y + 1},
      {x + 1, y - 1},
      {x, y + 1},
      {x, y - 1},
      {x + 1, y},
      {x - 1, y}
    ]
  end

  @spec solve(String.t(), :part1) :: integer
  def solve(input, :part1) do
    grid = parse_input(input)

    Enum.reduce(grid, 0, fn {{x, y}, char}, acc ->
      if char == "." do
        acc
      else
        match_count =
          neighbors({x, y})
          |> Enum.count(fn coord -> Map.get(grid, coord) == "@" end)

        if match_count < 4 do
          acc + 1
        else
          acc
        end
      end
    end)
  end

  @spec solve(String.t(), :part2) :: integer
  def solve(input, :part2) do
    initial_grid = parse_input(input)

    solve_loop(initial_grid, 0)
  end

  defp solve_loop(current_grid, total_sum) do
    {new_grid, changes_in_step} =
      Enum.reduce(current_grid, {current_grid, 0}, fn
        {coord, char}, {grid_acc, count_acc} ->
          if char == "." do
            {grid_acc, count_acc}
          else
            match_count =
              neighbors(coord)
              |> Enum.count(fn c -> Map.get(current_grid, c) == "@" end)

            if match_count < 4 do
              updated_grid = Map.put(grid_acc, coord, ".")
              {updated_grid, count_acc + 1}
            else
              {grid_acc, count_acc}
            end
          end
      end)

    if changes_in_step == 0 do
      total_sum
    else
      new_total_sum = total_sum + changes_in_step
      solve_loop(new_grid, new_total_sum)
    end
  end
end
