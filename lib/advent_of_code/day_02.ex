defmodule AdventOfCode.Day02 do
  def part1(_args) do
    AdventOfCode.Input.get!(2,2022)
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce(0,fn x, acc ->
      [o, m] = String.split(x, " ")
      acc + judge(o,m)
    end)
  end

  def judge_p1("A", "X"), do: 1+3
  def judge_p1("B", "X"), do: 1+0
  def judge_p1("C", "X"), do: 1+6
  def judge_p1("A", "Y"), do: 2+6
  def judge_p1("B", "Y"), do: 2+3
  def judge_p1("C", "Y"), do: 2+0
  def judge_p1("A", "Z"), do: 3+0
  def judge_p1("B", "Z"), do: 3+6
  def judge_p1("C", "Z"), do: 3+3

  def part2(_args) do
    AdventOfCode.Input.get!(2,2022)
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce(0,fn x, acc ->
      [o, m] = String.split(x, " ")
      acc + judge_pt2(o,m)
    end)
  end

  def judge_pt2("A", "X"), do: 3+0
  def judge_pt2("B", "X"), do: 1+0
  def judge_pt2("C", "X"), do: 2+0
  def judge_pt2("A", "Y"), do: 1+3
  def judge_pt2("B", "Y"), do: 2+3
  def judge_pt2("C", "Y"), do: 3+3
  def judge_pt2("A", "Z"), do: 2+6
  def judge_pt2("B", "Z"), do: 3+6
  def judge_pt2("C", "Z"), do: 1+6
end
