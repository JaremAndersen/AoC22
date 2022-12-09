defmodule AdventOfCode.Day09 do
  def part1(input) do
    [_h_pos, _t_pos, t_visited] =
      input
      |> Enum.reduce([{0, 0}, {0, 0}, []], fn [direction, count], [h_pos, t_pos, t_visited] ->
        move(h_pos, t_pos, t_visited, direction, String.to_integer(count))
      end)

    t_visited |> Enum.uniq() |> length
  end

  def move(h_pos, t_pos, t_visited, _direction, 0) do
    [h_pos, t_pos, t_visited]
  end

  def move(h_pos, t_pos, t_visited, direction, count) do
    new_head_pos = move_head(h_pos, direction)
    new_tail_pos = move_tail(new_head_pos, t_pos)
    new_visited = [new_tail_pos | t_visited]
    move(new_head_pos, new_tail_pos, new_visited, direction, count - 1)
  end

  def move_head({x, y}, "L") do
    {x - 1, y}
  end

  def move_head({x, y}, "R") do
    {x + 1, y}
  end

  def move_head({x, y}, "U") do
    {x, y + 1}
  end

  def move_head({x, y}, "D") do
    {x, y - 1}
  end

  def move_tail({hx, hy}, {tx, ty}) do
    x_dif = hx - tx
    y_dif = hy - ty

    new_x =
      cond do
        x_dif >= 2 -> tx + 1
        x_dif <= -2 -> tx - 1
        x_dif == 1 and abs(y_dif) >= 2 -> tx + 1
        x_dif == -1 and abs(y_dif) >= 2 -> tx - 1
        abs(x_dif) < 2 -> tx
      end

    new_y =
      cond do
        y_dif >= 2 -> ty + 1
        y_dif <= -2 -> ty - 1
        y_dif == 1 and abs(x_dif) >= 2 -> ty + 1
        y_dif == -1 and abs(x_dif) >= 2 -> ty - 1
        abs(y_dif) < 2 -> ty
      end

    {new_x, new_y}
  end

  # positions the draw function
  @start {12, 6}
  def part2(input) do
    @start = {12, 6}
    t_start = [@start, @start, @start, @start, @start, @start, @start, @start, @start]

    [_head_pos, _knot_pos, tail_visited] =
      input
      |> Enum.reduce(
        [@start, t_start, [@start]],
        fn [direction, count], [head_pos, knot_positions, tail_visited] ->
          move_knots(head_pos, knot_positions, tail_visited, direction, String.to_integer(count))
        end
      )

    tail_visited |> Enum.uniq() |> length
  end

  def move_knots(h_pos, t_positions, t_visited, _direction, 0) do
    [h_pos, t_positions, t_visited]
  end

  def move_knots(h_position, t_positions, t_visited, direction, count) do
    new_head_pos = move_head(h_position, direction)

    new_tail_positions = move_knots(new_head_pos, t_positions)

    # only sized for the example input
    # draw_knots(new_tail_positions)
    new_visited = [List.last(new_tail_positions) | t_visited]
    move_knots(new_head_pos, new_tail_positions, new_visited, direction, count - 1)
  end

  def move_knots(prev_pos, t_positions, cur_idx \\ 0)

  def move_knots(_prev_pos, t_positions, cur_idx)
      when cur_idx >= length(t_positions) do
    t_positions
  end

  def move_knots(prev_pos, t_positions, cur_idx) do
    current_pos = Enum.at(t_positions, cur_idx)
    new_current_pos = move_tail(prev_pos, current_pos)

    new_t_positions = replace_at(t_positions, new_current_pos, cur_idx)
    move_knots(new_current_pos, new_t_positions, cur_idx + 1)
  end

  def draw_knots(positions) do
    for y <- 0..26 do
      for x <- 0..26 do
        elem_pos = Enum.find_index(positions, fn pos -> pos == {x, y} end)

        cond do
          !is_nil(elem_pos) -> elem_pos + 1
          {x, y} == @start -> "S"
          true -> "."
        end
      end
      |> Enum.join(" ")
    end
    |> Enum.reverse()
    |> Enum.join("\n")
    |> IO.puts()
  end

  def replace_at(positions, new_position, idx) do
    Enum.with_index(positions, fn elem, x ->
      if x == idx do
        new_position
      else
        elem
      end
    end)
  end
end
