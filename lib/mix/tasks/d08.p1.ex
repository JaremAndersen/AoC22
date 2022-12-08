defmodule Mix.Tasks.D08.P1 do
  use Mix.Task

  import AdventOfCode.Day08

  @shortdoc "Day 08 Part 1"
  def run(args) do
    input =
      AdventOfCode.Input.get!(8, 2022)
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        String.graphemes(row)
      end)

    # input =
    #   "30373\n25512\n65332\n33549\n35390"
    #   |> String.split("\n")
    #   |> Enum.map(fn row ->
    #     String.graphemes(row)
    #   end)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
