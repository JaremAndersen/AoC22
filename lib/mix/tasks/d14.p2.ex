defmodule Mix.Tasks.D14.P2 do
  use Mix.Task

  import AdventOfCode.Day14

  @shortdoc "Day 14 Part 2"
  def run(args) do
    input =
      AdventOfCode.Input.get!(14, 2022)
      # "498,4 -> 498,6 -> 496,6\n503,4 -> 502,4 -> 502,9 -> 494,9"
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        points =
          String.split(line, " -> ", trim: true)
          |> Enum.map(fn x ->
            String.split(x, ",") |> Enum.map(&String.to_integer(&1)) |> Enum.into([])
          end)

        Enum.with_index(points, fn point, idx ->
          cond do
            idx < length(points) - 1 -> [point, Enum.at(points, idx + 1)]
            true -> nil
          end
        end)
        |> Enum.filter(fn x -> not is_nil(x) end)
      end)
      |> Enum.reduce([], fn lines, all_points ->
        new_points =
          Enum.map(lines, fn [[sx, sy], [ex, ey]] ->
            # IO.inspect(line, label: "line")

            cond do
              sx == ex ->
                # vertical lines
                Enum.map(sy..ey, fn y ->
                  {sx, y}
                end)

              sy == ey ->
                # horizontal lines
                Enum.map(sx..ex, fn x ->
                  {x, sy}
                end)
            end
          end)
          |> List.flatten()

        new_points ++ all_points
      end)
      |> Enum.uniq()

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
