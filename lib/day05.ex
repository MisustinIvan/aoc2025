defmodule Aoc2025.Day05 do
  @type input :: %{ranges: [Range.t()], ids: [integer]}

  @spec parse_input(String.t()) :: input
  defp parse_input(input) do
    input
    |> String.split("\n\n")
    |> then(fn [ranges_str, ids_str] ->
      %{
        ranges:
          ranges_str
          |> String.split("\n")
          |> Enum.map(fn r ->
            r
            |> String.split("-")
            |> then(fn [begin_s, end_s] ->
              String.to_integer(begin_s)..String.to_integer(end_s)
            end)
          end),
        ids: ids_str |> String.split("\n") |> Enum.map(&String.to_integer/1)
      }
    end)
  end

  @spec is_in_ranges(integer, []) :: 0
  defp is_in_ranges(_value, []) do
    0
  end

  @spec is_in_ranges(integer, [Range.t()]) :: integer
  defp is_in_ranges(value, [range | ranges]) do
    if(value in range) do
      1
    else
      is_in_ranges(value, ranges)
    end
  end

  @spec merge_to_disjoint_ranges([Range.t()]) :: [Range.t()]
  defp merge_to_disjoint_ranges(ranges) do
    ranges
    |> Enum.sort_by(fn s.._e//1 -> s end)
    |> merge_ranges([])
  end

  @spec ranges_touch_or_overlap(Range.t(), Range.t()) :: boolean
  def ranges_touch_or_overlap(range1, range2) do
    start1..end1//1 = range1
    start2..end2//1 = range2

    (start1 <= end2 && end1 >= start2) || (end1 + 1 == start2 || end2 + 1 == start1)
  end

  @spec merge_ranges([Range.t()], []) :: [Range.t()]
  defp merge_ranges([head | tail], []) do
    merge_ranges(tail, [head])
  end

  @spec merge_ranges([], [Range.t()]) :: [Range.t()]
  defp merge_ranges([], acc) do
    acc
  end

  @spec merge_ranges([Range.t()], [Range.t()]) :: [Range.t()]
  defp merge_ranges([head | tail], [acc_head | acc_tail]) do
    acc_start..acc_end//1 = acc_head
    _range_start..range_end//1 = head

    if ranges_touch_or_overlap(head, acc_head) do
      merge_ranges(tail, [acc_start..max(acc_end, range_end) | acc_tail])
    else
      merge_ranges(tail, [head, acc_head | acc_tail])
    end
  end

  @spec solve(String.t(), :part1) :: integer
  def solve(input, :part1) do
    input
    |> parse_input()
    |> then(fn %{ranges: ranges, ids: ids} ->
      ids |> Enum.map(fn id -> is_in_ranges(id, ranges) end)
    end)
    |> Enum.sum()
  end

  @spec solve(String.t(), :part2) :: non_neg_integer
  def solve(input, :part2) do
    input
    |> parse_input()
    |> then(fn %{ranges: ranges, ids: _ids} ->
      ranges
      |> merge_to_disjoint_ranges()
      |> Enum.map(&Range.size/1)
      |> Enum.sum()
    end)
  end
end
