defmodule Aoc2025.Day02 do
  require Integer

  @spec parse_input(String.t()) :: [Range.t()]
  defp parse_input(input) do
    input
    |> String.split(",")
    |> Enum.map(fn range -> range |> String.split("-") end)
    |> Enum.map(fn [a, b] ->
      {min, _} = Integer.parse(a)
      {max, _} = Integer.parse(b)
      min..max
    end)
  end

  @spec repeating(String.t()) :: boolean
  defp repeating(str) do
    doubled = str <> str
    String.contains?(String.slice(doubled, 1..-2//1), str)
  end

  @spec check(integer) :: integer
  defp check(num) do
    str = "#{num}"

    len = String.length(str)

    cond do
      rem(len, 2) != 0 ->
        0

      true ->
        {a, b} = String.split_at(str, div(len, 2))

        cond do
          a == b -> num
          true -> 0
        end
    end
  end

  @spec check2(integer) :: integer
  defp check2(num) do
    str = "#{num}"

    len = String.length(str)

    cond do
      repeating(str) ->
        num

      rem(len, 2) != 0 ->
        0

      true ->
        {a, b} = String.split_at(str, div(len, 2))

        cond do
          a == b -> num
          true -> 0
        end
    end
  end

  @spec solve(String.t(), :part1) :: integer
  def solve(input, :part1) do
    input
    |> parse_input
    |> Enum.map(fn range ->
      range
      |> Enum.reduce(0, fn el, acc -> acc + check(el) end)
    end)
    |> Enum.sum()
  end

  @spec solve(String.t(), :part2) :: integer
  def solve(input, :part2) do
    input
    |> parse_input
    |> Enum.map(fn range ->
      range
      |> Enum.reduce(0, fn el, acc -> acc + check2(el) end)
    end)
    |> Enum.sum()
  end
end
