defmodule Mix.Tasks.D09.P1 do
  use Mix.Task

  import AdventOfCode.Day09

  @shortdoc "Day 09 Part 1"
  def run(args) do
    input =
      AdventOfCode.Input.get!(9, 2022)
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, " ") end)

    # input =
    #   "R 4\nU 4\nL 3\nD 1\nR 4\nD 1\nL 5\nR 2"
    #   |> String.split("\n", trim: true)
    #   |> Enum.map(fn x -> String.split(x, " ") end)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
