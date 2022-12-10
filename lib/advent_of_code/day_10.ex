defmodule AdventOfCode.Day10 do
  def part1(input) do
    input
    |> Enum.reduce([1, 1, 0], fn command, [cycle, register, strength] ->
      new_strength = handle_strength(command, cycle, register, strength)
      [n_cycle, n_register] = execute(command, cycle, register)

      [n_cycle, n_register, new_strength]
    end)
  end

  def calculate_cycle_mut(cycle) do
    mod = rem(cycle, 40)

    cond do
      cycle == 18 -> 20
      cycle == 19 -> 20
      mod == 18 -> cycle + 2
      mod == 19 -> cycle + 1
      mod == 20 -> cycle
    end
  end

  def handle_strength("noop", cycle, register, strength)
      when cycle == 20 or cycle == 60 or cycle == 100 or cycle == 140 or cycle == 180 or
             cycle == 220 do
    strength + cycle * register
  end

  # hate this but nothing came to mind as a better way to do this
  def handle_strength("addx " <> _num, cycle, register, strength)
      when (cycle <= 20 and cycle >= 19) or
             (cycle <= 60 and cycle >= 59) or
             (cycle <= 100 and cycle >= 99) or
             (cycle <= 140 and cycle >= 139) or
             (cycle <= 180 and cycle >= 179) or
             (cycle <= 220 and cycle >= 219) do
    strength + calculate_cycle_mut(cycle) * register
  end

  def handle_strength(_command, _cycle, _register, strength) do
    strength
  end

  def execute("noop", cycle, register) do
    [cycle + 1, register]
  end

  def execute("addx " <> num, cycle, register) do
    num = String.to_integer(num)
    [cycle + 2, register + num]
  end

  def part2(input) do
    [_cycle, _register, pixels] =
      input
      |> Enum.reduce([1, 1, ""], fn command, [cycle, register, pixels] ->
        [n_cycle, n_register, n_pixels] = execute_2(command, cycle, register, pixels)

        [n_cycle, n_register, n_pixels]
      end)

    IO.puts(pixels)
    pixels
  end

  def draw(cycle, register, pixels) do
    cycle_mod = rem(cycle, 40)

    line_break =
      if cycle_mod == 0 do
        "\n"
      else
        ""
      end

    new_pixels =
      if cycle_mod >= register and cycle_mod <= register + 2 do
        pixels <> "#" <> line_break
      else
        pixels <> "." <> line_break
      end

    new_pixels
  end

  def execute_2("noop", cycle, register, pixels) do
    new_pixels = draw(cycle, register, pixels)
    [cycle + 1, register, new_pixels]
  end

  def execute_2("addx " <> num, cycle, register, pixels) do
    new_pixels_1 = draw(cycle, register, pixels)
    new_pixels_2 = draw(cycle + 1, register, new_pixels_1)

    num = String.to_integer(num)
    [cycle + 2, register + num, new_pixels_2]
  end
end
