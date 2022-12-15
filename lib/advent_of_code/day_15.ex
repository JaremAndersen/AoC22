defmodule AdventOfCode.Day15 do
  def part1(input) do
    beacons_sensors =
      Enum.reduce(input, %{}, fn {sensor, beacon}, sb ->
        Map.merge(sb, %{sensor => :sensor, beacon => :beacon})
      end)

    sensor_distances =
      Enum.reduce(input, %{}, fn {{sx, sy}, beacon}, distances ->
        dist = calc_distance({sx, sy}, beacon)
        Map.put(distances, {sx, sy}, dist)
      end)

    check_row(sensor_distances, beacons_sensors, 2_000_000)
  end

  def check_row(sensor_distances, bs, row) do
    in_row =
      Map.keys(sensor_distances)
      |> Enum.map(fn {x, _y} -> x end)

    min = Enum.min(in_row) - 1_100_000
    max = Enum.max(in_row) + 1_100_000

    Enum.reduce(min..max, 0, fn x, acc ->
      near_sensor =
        Enum.any?(sensor_distances, fn {{sx, sy}, s_dist} ->
          dist = calc_distance({sx, sy}, {x, row})

          !Map.has_key?(bs, {x, row}) && dist <= s_dist
        end)

      if near_sensor do
        acc + 1
      else
        acc
      end
    end)
  end

  def print(no_beacons) do
    IO.inspect(no_beacons)

    Enum.reduce(0..20, "", fn y, output ->
      row =
        Enum.map(0..20, fn x ->
          case Map.get(no_beacons, {x, y}) do
            :beacon -> "B"
            :sensor -> "S"
            :empty -> "#"
            :perim -> "#"
            _ -> "."
          end
        end)
        |> Enum.join("")

      output <> "#{y}" <> row <> "\n"
    end)
    |> IO.puts()
  end

  def calc_distance({sx, sy}, {bx, by}) do
    abs(sx - bx) + abs(sy - by)
  end

  def part2(input) do
    sensor_distances =
      Enum.reduce(input, %{}, fn {{sx, sy}, beacon}, distances ->
        dist = calc_distance({sx, sy}, beacon)
        Map.put(distances, {sx, sy}, dist)
      end)
      |> IO.inspect()

    perims =
      Enum.reduce(sensor_distances, %{}, fn {sensor, distance}, perims ->
        IO.inspect(sensor, label: "sensor")
        new_perims = find_perimeters({sensor, distance})
        sensors = %{sensor => :sensor}
        merged = Map.merge(new_perims, sensors)
        Map.merge(perims, merged)
      end)
      |> IO.inspect()

    {x, y} = check_perimeters(perims, sensor_distances)
    x * 4_000_000 + y
  end

  @lower_bound 0
  @upper_bound 4_000_000

  def check_perimeters(perims, sensors) do
    Enum.reduce_while(perims, nil, fn {{px, py}, _}, found ->
      near_sensor =
        Enum.any?(sensors, fn {{sx, sy}, s_dist} ->
          dist = calc_distance({sx, sy}, {px, py})

          dist <= s_dist or not in_bound({px, py})
        end)

      if near_sensor do
        {:cont, found}
      else
        {:halt, {px, py}}
      end
    end)
  end

  def in_bound({x, y}) do
    x >= @lower_bound and
      x <= @upper_bound and
      y >= @lower_bound and
      y <= @upper_bound
  end

  def find_perimeters({{sx, sy}, dist}) do
    Enum.reduce((sy - dist - 1)..(sy + dist + 1), %{}, fn y, perims ->
      x_delta = abs(abs(y - sy) - dist - 1)

      search_perims = %{{sx - x_delta, y} => :perim, {sx + x_delta, y} => :perim}
      Map.merge(perims, search_perims)
    end)
  end
end
