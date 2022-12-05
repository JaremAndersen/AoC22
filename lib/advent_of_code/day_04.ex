defmodule AdventOfCode.Day04 do
  def part1(input) do
    input
    |> Enum.reduce(0, fn pairs, acc ->
      [p1, p2] =
        String.split(pairs, ",")
        |> Enum.map(fn pair ->
          String.split(pair, "-")
          |> Enum.map(&String.to_integer/1)
        end)

      p1_map = for(n <- Enum.at(p1, 0)..Enum.at(p1, 1), do: n) |> MapSet.new()
      p2_map = for(n <- Enum.at(p2, 0)..Enum.at(p2, 1), do: n) |> MapSet.new()

      if MapSet.subset?(p1_map, p2_map) || MapSet.subset?(p2_map, p1_map) do
        1 + acc
      else
        acc
      end
    end)
  end

  def part2(input) do
    input
    |> Enum.reduce(0, fn pairs, acc ->
      [p1, p2] =
        String.split(pairs, ",")
        |> Enum.map(fn pair ->
          String.split(pair, "-")
          |> Enum.map(&String.to_integer/1)
        end)

      p1_map = for(n <- Enum.at(p1, 0)..Enum.at(p1, 1), do: n) |> MapSet.new()
      p2_map = for(n <- Enum.at(p2, 0)..Enum.at(p2, 1), do: n) |> MapSet.new()

      if MapSet.intersection(p1_map, p2_map) |> MapSet.size() > 0 do
        1 + acc
      else
        acc
      end
    end)
  end
end
