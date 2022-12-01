defmodule AdventOfCode.Day01 do
  def part1(_args) do
    AdventOfCode.Input.get!(1,2022)
    |> String.split("\n\n")
    |> Enum.map( fn x ->
      String.split(x,"\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
    |> Enum.max()
  end

  def part2(_args) do
    AdventOfCode.Input.get!(1,2022)
    |> String.split("\n\n")
    |> Enum.map( fn x ->
      String.split(x,"\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.sum
  end
end
