defmodule Mix.Tasks.D13.P2 do
  use Mix.Task

  @moduledoc """
    Much cleaner but less fun way to parse the input
  """
  import AdventOfCode.Day13

  @shortdoc "Day 13 Part 2"
  def run(args) do
    input =
      AdventOfCode.Input.get!(13, 2022)
      # "[1,1,3,1,1]\n[1,1,5,1,1]\n\n[[1],[2,3,4]]\n[[1],4]\n\n[9]\n[[8,7,6]]\n\n[[4,4],4,4]\n[[4,4],4,4,4]\n\n[7,7,7,7]\n[7,7,7]\n\n[]\n[3]\n\n[[[]]]\n[[]]\n\n[1,[2,[3,[4,[5,6,7]]]],8,9]\n[1,[2,[3,[4,[5,6,0]]]],8,9]"
      |> String.split("\n", trim: true)
      |> Enum.map(fn x ->
        {result, _} = Code.eval_string(x)
        result
      end)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
