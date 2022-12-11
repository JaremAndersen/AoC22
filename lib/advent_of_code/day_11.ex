defmodule AdventOfCode.Day11 do
  # pt 1 mod
  # @mod 23 * 19 * 13 * 17

  # pt 2 mod
  @mod 17 * 3 * 5 * 7 * 11 * 19 * 2 * 13

  @monkeys %{
    0 => %{
      items: [54, 89, 94],
      operation: "old * 7",
      divisible_test: 17,
      true: 5,
      false: 3,
      inspected: 0
    },
    1 => %{
      items: [66, 71],
      operation: "old + 4",
      divisible_test: 3,
      true: 0,
      false: 3,
      inspected: 0
    },
    2 => %{
      items: [76, 55, 80, 55, 55, 96, 78],
      operation: "old + 2",
      divisible_test: 5,
      true: 7,
      false: 4,
      inspected: 0
    },
    3 => %{
      items: [93, 69, 76, 66, 89, 54, 59, 94],
      operation: "old + 7",
      divisible_test: 7,
      true: 5,
      false: 2,
      inspected: 0
    },
    4 => %{
      items: [80, 54, 58, 75, 99],
      operation: "old * 17",
      divisible_test: 11,
      true: 1,
      false: 6,
      inspected: 0
    },
    5 => %{
      items: [69, 70, 85, 83],
      operation: "old + 8",
      divisible_test: 19,
      true: 2,
      false: 7,
      inspected: 0
    },
    6 => %{
      items: [89],
      operation: "old + 6",
      divisible_test: 2,
      true: 0,
      false: 1,
      inspected: 0
    },
    7 => %{
      items: [62, 80, 58, 57, 93, 56],
      operation: "old * old",
      divisible_test: 13,
      true: 6,
      false: 4,
      inspected: 0
    }
  }

  # @monkeys %{
  #   0 => %{
  #     items: [79, 98],
  #     operation: "old * 19",
  #     divisible_test: 23,
  #     true: 2,
  #     false: 3,
  #     inspected: 0
  #   },
  #   1 => %{
  #     items: [54, 65, 75, 74],
  #     operation: "old + 6",
  #     divisible_test: 19,
  #     true: 2,
  #     false: 0,
  #     inspected: 0
  #   },
  #   2 => %{
  #     items: [79, 60, 97],
  #     operation: "old * old",
  #     divisible_test: 13,
  #     true: 1,
  #     false: 3,
  #     inspected: 0
  #   },
  #   3 => %{
  #     items: [74],
  #     operation: "old + 3",
  #     divisible_test: 17,
  #     true: 0,
  #     false: 1,
  #     inspected: 0
  #   }
  # }

  def part1(_args) do
    rounds = for rounds <- 1..10_000, do: rounds

    rounds
    |> Enum.reduce(@monkeys, fn _round, monkey_round ->
      Enum.reduce(monkey_round, monkey_round, fn {id, _monkey}, monkeys ->
        monkey = {id, monkeys[id]}
        inspect_items(monkey, monkeys)
      end)
    end)

    # |> IO.inspect(charlists: :as_lists)
  end

  def inspect_items({_id, keys} = monkey, monkeys) do
    Enum.reduce(keys.items, monkeys, fn item, monkeys ->
      inspect_item(monkey, monkeys, item)
    end)
  end

  def inspect_item({id, keys}, monkeys, item) do
    # pt 1 math
    # worry_level = worry_level(item, keys.operation)

    # pt2 math
    worry_level = rem(worry_level(item, keys.operation), @mod)

    new_monkey_id =
      if rem(worry_level, keys.divisible_test) == 0 do
        keys.true
      else
        keys.false
      end

    toss_item(monkeys, worry_level, id, new_monkey_id)
  end

  def worry_level(item, operation) do
    [_old, operator, number] = String.split(operation)

    cond do
      number == "old" and operator == "*" -> item * item
      operator == "+" -> item + String.to_integer(number)
      operator == "*" -> item * String.to_integer(number)
    end
  end

  def toss_item(monkeys, item, from_id, to_id) do
    Enum.with_index(monkeys, fn {id, keys}, x ->
      cond do
        x == to_id ->
          {to_id,
           Map.update(keys, :items, [item], fn existing_items -> existing_items ++ [item] end)}

        x == from_id ->
          updated_items = Map.update(keys, :items, [item], fn [_head | tail] -> tail end)

          updated_inspected =
            Map.update(updated_items, :inspected, 0, fn existing -> existing + 1 end)

          {from_id, updated_inspected}

        true ->
          {id, keys}
      end
    end)
    |> Enum.into(%{})
  end

  def part2(_args) do
  end
end
