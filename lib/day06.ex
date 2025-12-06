defmodule Aoc2025.Day06 do
  @spec parse_input(String.t(), :part1) :: {[String.t()], [[integer]]}
  defp parse_input(input, :part1) do
    input
    |> String.split("\n")
    |> then(fn list ->
      {
        List.last(list) |> String.split(),
        Enum.take(list, length(list) - 1)
        |> Enum.map(fn line -> line |> String.split() |> Enum.map(&String.to_integer/1) end)
      }
    end)
  end

  @spec parse_input(String.t(), :part2) :: [[String.t()]]
  defp parse_input(input, :part2) do
    input
    |> String.split("\n")
    |> Enum.map(fn line -> line <> " " end)
    |> then(fn list ->
      last = List.last(list)
      list = List.delete_at(list, -1)
      [last | list]
    end)
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @spec solve(String.t(), :part1) :: integer
  def solve(input, :part1) do
    input
    |> parse_input(:part1)
    |> then(fn {operators, values} ->
      Enum.zip_with(operators, Enum.zip(values), fn operator, values ->
        {operator, Tuple.to_list(values)}
      end)
    end)
    |> Enum.map(fn {operator, values} ->
      case operator do
        "*" ->
          values |> Enum.reduce(1, &(&1 * &2))

        "+" ->
          values |> Enum.reduce(0, &(&1 + &2))
      end
    end)
    |> Enum.sum()
  end

  @spec solve(String.t(), :part2) :: atom
  def solve(input, :part2) do
    input
    |> parse_input(:part2)
    |> Enum.reduce(%{operator: nil, acc: 0, total_acc: 0}, fn [possible_operator | values],
                                                              %{
                                                                operator: operator,
                                                                acc: acc,
                                                                total_acc: total_acc
                                                              } ->
      joined_values = values |> Enum.join() |> String.trim()

      cond do
        possible_operator == " " && joined_values == "" ->
          %{
            operator: nil,
            acc: 0,
            total_acc: total_acc + acc
          }

        possible_operator == "*" || possible_operator == "+" ->
          %{
            operator: possible_operator,
            acc: String.to_integer(joined_values),
            total_acc: total_acc
          }

        operator == "*" ->
          %{
            operator: operator,
            acc: acc * String.to_integer(joined_values),
            total_acc: total_acc
          }

        operator == "+" ->
          %{
            operator: operator,
            acc: acc + String.to_integer(joined_values),
            total_acc: total_acc
          }
      end
    end)
    |> then(fn %{
                 operator: _,
                 acc: _,
                 total_acc: total_acc
               } ->
      total_acc
    end)
  end
end
