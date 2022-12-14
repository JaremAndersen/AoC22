defmodule AdventOfCode.Day14 do
  @moduledoc """
    So much fun! Reaffirmed a few things for myself on this one. Indexing into a list is crazy slow. If you an use a map for a lookup always do that.
    Also I sure do love a visualizer.
  """

  @drop_point {500, 0}

  def part1(input) do
    rocks = input

    sand =
      Enum.reduce_while(0..1_000_000, [], fn _idx, sand ->
        occupied = rocks ++ sand
        new_sand = simulate_sand(occupied)

        if is_nil(new_sand) do
          {:halt, sand}
        else
          {:cont, [new_sand | sand]}
        end
      end)

    # draw(rocks, sand)

    length(sand)
  end

  def simulate_sand(occupied, {cur_x, cur_y} \\ @drop_point) do
    {status, pos} =
      cond do
        # check if void
        cur_y >= 600 ->
          {:void, nil}

        # move straight down
        !Enum.any?(occupied, fn x -> x == {cur_x, cur_y + 1} end) ->
          {:falling, {cur_x, cur_y + 1}}

        # move down left
        !Enum.any?(occupied, fn x -> x == {cur_x - 1, cur_y + 1} end) ->
          {:falling, {cur_x - 1, cur_y + 1}}

        # move down right
        !Enum.any?(occupied, fn x -> x == {cur_x + 1, cur_y + 1} end) ->
          {:falling, {cur_x + 1, cur_y + 1}}

        # cant move any lower return current position
        true ->
          {:stopped, {cur_x, cur_y}}
      end

    cond do
      status == :falling -> simulate_sand(occupied, pos)
      status == :stopped and pos == @drop_point -> pos
      status == :stopped -> pos
      status == :void -> nil
    end
  end

  def draw(rocks, sand) do
    Enum.reduce(0..200, "", fn y, output ->
      line =
        Enum.map(400..650, fn x ->
          cond do
            Enum.any?(rocks, fn point -> point == {x, y} end) -> "X"
            Enum.any?(sand, fn point -> point == {x, y} end) -> "O"
            {x, y} == @drop_point -> "+"
            true -> "."
          end
        end)
        |> Enum.join("")

      output <> line <> "\n"
    end)
    |> IO.puts()
  end

  def part2(input) do
    objects = input |> Enum.into(%{}, fn {x, y} -> {{x, y}, :rock} end)

    floor = (Enum.map(input, fn {_x, y} -> y end) |> Enum.max()) + 2

    object_with_floor = build_floor(floor, objects)

    all =
      Enum.reduce_while(0..1_000_000, object_with_floor, fn _idx, objects_acc ->
        new_sand = simulate_sand_floor(objects_acc, floor)

        if is_nil(new_sand) do
          {:halt, objects_acc}
        else
          {:cont, Map.put(objects_acc, new_sand, :sand)}
        end
      end)

    Map.values(all)
    |> Enum.filter(fn x -> x == :sand end)
    |> length()

    # draw(rocks, sand)
  end

  def simulate_sand_floor(occupied, floor_y, {cur_x, cur_y} \\ @drop_point) do
    {status, pos} =
      cond do
        # check if void
        cur_y >= 600 ->
          {:void, nil}

        !Map.has_key?(occupied, {cur_x, cur_y + 1}) ->
          {:falling, {cur_x, cur_y + 1}}

        # move down left
        !Map.has_key?(occupied, {cur_x - 1, cur_y + 1}) ->
          {:falling, {cur_x - 1, cur_y + 1}}

        # move down right
        !Map.has_key?(occupied, {cur_x + 1, cur_y + 1}) ->
          {:falling, {cur_x + 1, cur_y + 1}}

        # cant move any lower return current position
        true ->
          {:stopped, {cur_x, cur_y}}
      end

    cond do
      status == :falling -> simulate_sand_floor(occupied, floor_y, pos)
      status == :stopped and pos == @drop_point -> pos
      status == :stopped -> pos
      status == :void -> nil
    end
  end

  def build_floor(floor_height, objects) do
    Enum.reduce(-100_000..100_000, objects, fn x, objects_acc ->
      Map.put(objects_acc, {x, floor_height}, :rock)
    end)
  end
end
