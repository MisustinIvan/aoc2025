defmodule Aoc2025.Day03 do
  @spec parse_input(String.t()) :: [[integer]]
  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn batteries ->
      batteries
      |> String.graphemes()
      |> Enum.map(fn battery ->
        {val, _} = Integer.parse(battery)
        val
      end)
    end)
  end

  @spec interval_max([integer]) :: {integer, integer}
  defp interval_max(interval) do
    interval
    |> Enum.with_index()
    |> Enum.max_by(fn {value, _index} -> value end)
  end

  @spec collect_maxes([integer], integer, integer, [integer]) :: [integer]
  defp collect_maxes(batteries, amount, idx, acc) do
    if length(acc) == amount do
      acc
    else
      window_size = length(batteries) - idx - amount + 1 + length(acc)
      range = idx..(idx + window_size - 1)

      window = Enum.slice(batteries, range)

      {max, local_idx} = interval_max(window)

      collect_maxes(batteries, amount, idx + local_idx + 1, [max | acc])
    end
  end

  @spec get_joltage([integer], integer) :: integer
  defp get_joltage(batteries, amount) do
    batteries
    |> collect_maxes(amount, 0, [])
    |> Enum.with_index()
    |> Enum.reduce(0, fn {n, idx}, acc -> acc + n * :math.pow(10, idx) end)
  end

  @spec solve(String.t(), :part1) :: integer
  def solve(input, :part1) do
    input
    |> parse_input
    |> Enum.map(fn batteries -> batteries |> get_joltage(2) end)
    |> Enum.sum()
  end

  @spec solve(String.t(), :part2) :: integer
  def solve(input, :part2) do
    input
    |> parse_input
    |> Enum.map(fn batteries -> batteries |> get_joltage(12) end)
    |> Enum.sum()
  end
end
