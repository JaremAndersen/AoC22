defmodule Mix.Tasks.D15.P2 do
  use Mix.Task

  import AdventOfCode.Day15

  @shortdoc "Day 15 Part 2"
  def run(args) do
    # "Sensor at x=8, y=7: closest beacon is at x=2, y=10\n"
    input =
      AdventOfCode.Input.get!(15, 2022)
      # "Sensor at x=2, y=18: closest beacon is at x=-2, y=15\nSensor at x=9, y=16: closest beacon is at x=10, y=16\nSensor at x=13, y=2: closest beacon is at x=15, y=3\nSensor at x=12, y=14: closest beacon is at x=10, y=16\nSensor at x=10, y=20: closest beacon is at x=10, y=16\nSensor at x=14, y=17: closest beacon is at x=10, y=16\nSensor at x=8, y=7: closest beacon is at x=2, y=10\nSensor at x=2, y=0: closest beacon is at x=2, y=10\nSensor at x=0, y=11: closest beacon is at x=2, y=10\nSensor at x=20, y=14: closest beacon is at x=25, y=17\nSensor at x=17, y=20: closest beacon is at x=21, y=22\nSensor at x=16, y=7: closest beacon is at x=15, y=3\nSensor at x=14, y=3: closest beacon is at x=15, y=3\nSensor at x=20, y=1: closest beacon is at x=15, y=3"
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        items = String.split(line, " ", trim: true)

        sx =
          Enum.at(items, 2)
          |> String.split("=")
          |> Enum.at(1)
          |> String.replace(",", "")
          |> String.to_integer()

        sy =
          Enum.at(items, 3)
          |> String.split("=")
          |> Enum.at(1)
          |> String.replace(":", "")
          |> String.to_integer()

        bx =
          Enum.at(items, 8)
          |> String.split("=")
          |> Enum.at(1)
          |> String.replace(",", "")
          |> String.to_integer()

        by =
          Enum.at(items, 9)
          |> String.split("=")
          |> Enum.at(1)
          |> String.replace(":", "")
          |> String.to_integer()

        [{sx, sy}, {bx, by}]
      end)
      |> Enum.into(%{}, fn [{sx, sy}, {bx, by}] -> {{sx, sy}, {bx, by}} end)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
