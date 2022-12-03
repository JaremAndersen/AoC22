defmodule AdventOfCode.Day03 do
  @alphabet ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
  @weight  for n <- 0..51, into: %{}, do: {Enum.at(@alphabet,n), n + 1}

  def part1(_args) do
    AdventOfCode.Input.get!(3,2022)
    |> String.split("\n", trim: true)
    |>Enum.reduce(0, fn x, acc ->
      {x,y} =String.split_at(x, ((String.length(x)) / 2) |> trunc())
      x_chars = String.graphemes(x)|> MapSet.new()
      y_chars = String.graphemes(y)|> MapSet.new()

      batch_total = MapSet.intersection(x_chars, y_chars) |>  Enum.reduce(0, fn dup, sum ->
        @weight[dup] + sum
      end)

      batch_total + acc
    end)
  end

  def part2(input) do
    input |> Enum.chunk_every(3)
    |> Enum.reduce(0,fn [x,y,z], sum ->
      x_chars = String.graphemes(x)|> MapSet.new()
      y_chars = String.graphemes(y)|> MapSet.new()
      z_chars = String.graphemes(z)|> MapSet.new()

      badge = MapSet.intersection(x_chars, MapSet.intersection(y_chars, z_chars)) |> Enum.at(0)
      @weight[badge] + sum
    end)

  end
end
