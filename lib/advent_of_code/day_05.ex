defmodule AdventOfCode.Day05 do
  @stacks [
    ["V", "R", "H", "B", "G", "D", "W"],
    ["F", "R", "C", "G", "N", "J"],
    ["J", "N", "D", "H", "F", "S", "L"],
    ["V", "S", "D", "J"],
    ["V", "N", "W", "W", "R", "D", "H", "S"],
    ["M", "C", "H", "G", "P"],
    ["C", "H", "Z", "L", "G", "B", "J", "F"],
    ["R", "J", "S"],
    ["M", "V", "N", "B", "R", "S", "G", "L"]
  ]

  def part1(input) do
    input
    |> Enum.reduce(@stacks, fn move, stacks ->
      move(move, stacks)
    end)
  end

  def move(move, input_stacks) do
    [_, quantity, _, source, _, destination] = String.split(move, " ")

    quantity_to_take = for x <- 1..String.to_integer(quantity), do: x

    source_idx = String.to_integer(source) - 1
    destination_idx = String.to_integer(destination) - 1

    Enum.reduce(quantity_to_take, input_stacks, fn _x, stacks ->
      to_move =
        Enum.take(
          Enum.at(stacks, source_idx),
          1
        )
        |> List.first()

      cur_source = Enum.at(stacks, source_idx)

      new_source =
        Enum.take(
          cur_source,
          length(cur_source) * -1 + 1
        )

      dest = Enum.at(stacks, destination_idx)

      new_dest =
        if is_nil(to_move) do
          dest
        else
          [to_move | dest]
        end

      Enum.with_index(stacks, fn x, i ->
        cond do
          i == source_idx -> new_source
          i == destination_idx -> new_dest
          true -> x
        end
      end)
    end)
  end

  def part2(input) do
    input
    |> Enum.reduce(@stacks, fn move, stacks ->
      move_multi(move, stacks)
    end)
  end

  def move_multi(move, input_stacks) do
    [_, quantity, _, source, _, destination] = String.split(move, " ")

    source_idx = String.to_integer(source) - 1
    destination_idx = String.to_integer(destination) - 1

    to_move =
      Enum.take(
        Enum.at(input_stacks, source_idx),
        String.to_integer(quantity)
      )

    cur_source = Enum.at(input_stacks, source_idx)

    new_source =
      Enum.take(
        cur_source,
        length(cur_source) * -1 + String.to_integer(quantity)
      )

    dest = Enum.at(input_stacks, destination_idx)

    new_dest = to_move ++ dest

    Enum.with_index(input_stacks, fn x, i ->
      cond do
        i == source_idx -> new_source
        i == destination_idx -> new_dest
        true -> x
      end
    end)
  end
end
