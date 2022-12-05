defmodule Mix.Tasks.D05.P2 do
  use Mix.Task

  import AdventOfCode.Day05

  @shortdoc "Day 05 Part 2"
  def run(args) do
    [_, input] =
      AdventOfCode.Input.get!(5, 2022)
      |> String.split("9 \n\n", trim: true)

    moves = String.split(input, "\n", trim: true)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> moves |> part2() end}),
      else:
        moves
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
