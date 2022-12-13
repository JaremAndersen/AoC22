defmodule Mix.Tasks.D13.P1 do
  @moduledoc """
    Had some fun with the input on this one. I knew something like Code.eval_string had to exist but after I came up with idea i decided to try it out just for laughs. Worked a treat.
  """
  use Mix.Task

  import AdventOfCode.Day13

  @shortdoc "Day 13 Part 1"
  def run(args) do
    start_file()

    AdventOfCode.Input.get!(13, 2022)

    # "[1,1,3,1,1]\n[1,1,5,1,1]\n\n[[1],[2,3,4]]\n[[1],4]\n\n[9]\n[[8,7,6]]\n\n[[4,4],4,4]\n[[4,4],4,4,4]\n\n[7,7,7,7]\n[7,7,7]\n\n[]\n[3]\n\n[[[]]]\n[[]]\n\n[1,[2,[3,[4,[5,6,7]]]],8,9]\n[1,[2,[3,[4,[5,6,0]]]],8,9]"
    |> String.split("\n\n", trim: true)
    |> Enum.with_index(fn x, idx ->
      [first, second] = String.split(x, "\n", trim: true)
      write_list(idx, first, second)
      [first, second]
    end)
    |> end_file()

    input = nil

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end

  def start_file() do
    File.write("./lib/d13input.ex", "defmodule AdventOfCode.Day13.Input do\n")
  end

  def end_file(list) do
    all =
      Enum.with_index(list, fn _elem, idx ->
        "@pair#{idx}"
      end)
      |> Enum.join(",")

    File.write("./lib/d13input.ex", "def input(), do: [#{all}] \n end", [:append])
  end

  def write_list(index, first, second) do
    content = "@pair#{index} " <> "[#{first}, #{second}]\n"
    File.write("./lib/d13input.ex", content, [:append])
  end
end
