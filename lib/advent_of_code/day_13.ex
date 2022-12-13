defmodule AdventOfCode.Day13 do
  alias AdventOfCode.Day13.Input

  def part1(_args) do
    input = Input.input()

    Enum.with_index(input, fn [left, right], idx ->
      out = check_order(left, right)

      if is_nil(out) or out do
        idx + 1
      else
        0
      end
    end)
    |> Enum.sum()
  end

  def check_order(left, right)

  def check_order([left_head | left_tail], [right_head | right_tail]) do
    order = check_order(left_head, right_head)

    if is_nil(order) do
      check_order(left_tail, right_tail)
    else
      order
    end
  end

  def check_order([], [_right_head | _right_tail]), do: true
  def check_order([_left_head | _left_tail], []), do: false
  def check_order([], []), do: nil

  def check_order(left, right) when is_list(left) and is_integer(right) do
    check_order(left, [right])
  end

  def check_order(left, right) when is_integer(left) and is_list(right) do
    check_order([left], right)
  end

  def check_order(left, right)
      when is_integer(left) and is_integer(right) and left != right do
    left < right
  end

  def check_order(left, right)
      when is_integer(left) and is_integer(right) and left == right do
    nil
  end

  def part2(input) do
    input_with_divider = input ++ [[[2]], [[6]]]

    sorted = Enum.sort(input_with_divider, &check_order(&1, &2))

    first_divider = Enum.find_index(sorted, fn x -> x == [[2]] end) + 1
    second_divider = Enum.find_index(sorted, fn x -> x == [[6]] end) + 1

    first_divider * second_divider
  end
end
