defmodule Mix.Tasks.D08.P2 do
  use Mix.Task

  import AdventOfCode.Day08

  @shortdoc "Day 08 Part 2"
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
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
