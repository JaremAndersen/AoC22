defmodule Mix.Tasks.D07.P1 do
  use Mix.Task

  import AdventOfCode.Day07

  @shortdoc "Day 07 Part 1"
  def run(args) do
    input =
      AdventOfCode.Input.get!(7, 2022)
      |> String.split("$ ", trim: true)
      |> Enum.map(fn block ->
        String.split(block, "\n", trim: true)
      end)

    # input =
    #   "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k"
    #   |> String.split("$ ", trim: true)
    #   |> Enum.map(fn block ->
    #     String.split(block, "\n", trim: true)
    #   end)

    # |> String.split("\n", trim: true)

    # |> String.split("\n", trim: true)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
