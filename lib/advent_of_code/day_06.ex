defmodule AdventOfCode.Day06 do
  def part1(input) do
    input |> find_start(4)
  end

  def find_start(enum, target_size, start \\ 0) do
    uniq_count =
      enum
      |> Enum.slice(start, target_size)
      |> Enum.uniq()
      |> length

    if uniq_count == target_size do
      start + target_size
    else
      find_start(enum, target_size, start + 1)
    end
  end

  def part2(input) do
    input |> find_start(14)
  end
end
