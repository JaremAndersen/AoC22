defmodule Mix.Tasks.D05.P1 do
  use Mix.Task

  import AdventOfCode.Day05

  @shortdoc "Day 05 Part 1"
  def run(args) do
    [_, input] =
      AdventOfCode.Input.get!(5, 2022)
      |> String.split("9 \n\n", trim: true)

    moves = String.split(input, "\n", trim: true)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> moves |> part1() end}),
      else:
        moves
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
