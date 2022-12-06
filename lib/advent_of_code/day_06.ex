defmodule AdventOfCode.Day06 do
  def part1(input) do
    input |> String.graphemes() |> find_start(0, 4)
  end

  def find_start(enum, start, target_size) do
    if Enum.slice(enum, start, target_size) |> MapSet.new() |> MapSet.size() < target_size do
      find_start(enum, start + 1, target_size)
    else
      start + target_size
    end
  end

  def part2(input) do
    input |> String.graphemes() |> find_start(0, 14)
  end
end
