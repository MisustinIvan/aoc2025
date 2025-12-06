defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @shortdoc "run the aoc solution"
  @moduledoc """
  runs an aoc solution for a given day.

      mix aoc <day> [--part PART]

  examples:

      mix aoc 1
      mix aoc 1 --part 2
      mix aoc 5 --part both
  """

  def run(args) do
    case parse(args) do
      {:ok, day, part} -> run_day(day, part)
      :help -> Mix.shell().info(usage())
    end
  end

  defp parse([day_str | rest]) do
    part = parse_part_option(rest)

    with {day, ""} <- Integer.parse(day_str) do
      {:ok, day, part}
    else
      _ -> :help
    end
  end

  defp parse(_), do: :help

  defp parse_part_option(["--part", p]) when p in ["1", "2", "both"], do: p
  defp parse_part_option(_), do: "both"

  defp usage do
    """
    Usage:
      mix aoc <day> [--part 1|2|both]
    """
  end

  defp run_day(day, part) do
    mod = [:"Aoc2025.Day#{:io_lib.format("~2..0B", [day])}"] |> Module.concat()
    input = load_input(day)

    unless Code.ensure_loaded?(mod) and function_exported?(mod, :solve, 2) do
      Mix.raise("Day #{day} not implemented: #{inspect(mod)}")
    end

    case part do
      "1" ->
        measure(fn -> mod.solve(input, :part1) end)

      "2" ->
        measure(fn -> mod.solve(input, :part2) end)

      "both" ->
        measure(fn -> mod.solve(input, :part1) end)
        measure(fn -> mod.solve(input, :part2) end)
    end
  end

  defp load_input(day) do
    Path.join(:code.priv_dir(:aoc2025), "inputs/day#{:io_lib.format("~2..0B", [day])}.txt")
    |> File.read!()
    |> String.trim_trailing("\n")
  end

  defp measure(fun) do
    start = System.monotonic_time(:millisecond)
    result = fun.()
    stop = System.monotonic_time(:millisecond)

    Mix.shell().info("Result: #{inspect(result)}")
    Mix.shell().info("Time: #{stop - start} ms\n")

    result
  end
end
