defmodule Mix.Tasks.D09.P2 do
  use Mix.Task

  import AdventOfCode.Day09

  @shortdoc "Day 09 Part 2"
  def run(args) do
    input =
      AdventOfCode.Input.get!(9, 2022)
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, " ") end)

    # input =
    #   "R 5\nU 8\nL 8\nD 3\nR 17\nD 10\nL 25\nU 20"

    #   # "R 4\nU 4\nL 3\nD 1\nR 4\nD 1\nL 5\nR 2"
    #   |> String.split("\n", trim: true)
    #   |> Enum.map(fn x -> String.split(x, " ") end)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
