defmodule Aoc2025.Day01 do
  @spec parse_input(String.t()) :: [integer]
  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn instruction ->
      case instruction do
        "R" <> amount ->
          {num, _} = Integer.parse(amount)
          num

        "L" <> amount ->
          {num, _} = Integer.parse(amount)
          -num
      end
    end)
  end

  @spec solve(String.t(), :part1) :: {integer, integer}
  def solve(input, :part1) do
    input
    |> parse_input
    |> Enum.reduce({0, 50}, fn move, {acc, pos} ->
      case Integer.mod(pos + move, 100) do
        0 -> {acc + 1, 0}
        n -> {acc, n}
      end
    end)
  end

  @spec solve(String.t(), :part2) :: {integer, integer}
  def solve(input, :part2) do
    input
    |> parse_input
    |> Enum.reduce({0, 50}, fn move, {acc, pos} ->
      new_pos = pos + move
      new_pos_wrapped = Integer.mod(new_pos, 100)

      cond do
        new_pos >= 100 ->
          {acc + div(new_pos, 100), new_pos_wrapped}

        new_pos <= 0 ->
          {
            acc + div(new_pos, -100) + 1 +
              cond do
                pos == 0 -> -1
                true -> 0
              end,
            new_pos_wrapped
          }

        true ->
          {acc, new_pos_wrapped}
      end
    end)
  end
end
