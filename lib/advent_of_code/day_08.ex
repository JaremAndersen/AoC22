defmodule AdventOfCode.Day08 do
  def part1(input) do
    hidden_x =
      input
      |> Enum.map(fn row ->
        Enum.with_index(row, fn _col, col_idx ->
          hidden_left = hidden_left(col_idx, row)
          hidden_right = hidden_right(col_idx, row)
          hidden_right and hidden_left
        end)
      end)

    hidden_y =
      input
      |> invert()
      |> Enum.map(fn row ->
        Enum.with_index(row, fn _col, col_idx ->
          hidden_left = hidden_left(col_idx, row)
          hidden_right = hidden_right(col_idx, row)
          hidden_left and hidden_right
        end)
      end)
      |> invert()

    for x <- 0..(length(hidden_x) - 1), reduce: 0 do
      total ->
        total +
          for y <- 0..(length(Enum.at(hidden_x, 0)) - 1), reduce: 0 do
            row_count ->
              x_row = Enum.at(hidden_x, x)
              y_row = Enum.at(hidden_y, x)

              x_val = Enum.at(x_row, y)
              y_val = Enum.at(y_row, y)

              if x_val and y_val do
                row_count
              else
                row_count + 1
              end
          end
    end
  end

  def invert(grid) do
    grid
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def hidden_left(col_idx, row) do
    idx_height = Enum.at(row, col_idx)

    if col_idx > 0 do
      max_left = Enum.slice(row, 0, col_idx) |> Enum.max()
      idx_height <= max_left
    else
      false
    end
  end

  def hidden_right(col_idx, row) do
    idx_height = Enum.at(row, col_idx)

    row_length =
      row
      |> length

    if col_idx < row_length - 1 do
      max_right =
        Enum.slice(row, col_idx + 1, row_length - 1)
        |> Enum.max()

      idx_height <= max_right
    else
      false
    end
  end

  def part2(input) do
    hidden_x =
      input
      |> Enum.map(fn row ->
        Enum.with_index(row, fn _col, col_idx ->
          scenic_left = scenic_left(col_idx, row)
          scenic_right = scenic_right(col_idx, row)
          scenic_left * scenic_right
        end)
      end)

    hidden_y =
      input
      |> invert()
      |> Enum.map(fn row ->
        Enum.with_index(row, fn _col, col_idx ->
          scenic_left = scenic_left(col_idx, row)
          scenic_right = scenic_right(col_idx, row)
          scenic_left * scenic_right
        end)
      end)
      |> invert()

    for x <- 0..(length(hidden_x) - 1) do
      for y <- 0..(length(Enum.at(hidden_x, 0)) - 1), reduce: 0 do
        row_highest ->
          x_row = Enum.at(hidden_x, x)
          y_row = Enum.at(hidden_y, x)

          x_val = Enum.at(x_row, y)
          y_val = Enum.at(y_row, y)

          if x_val * y_val > row_highest do
            x_val * y_val
          else
            row_highest
          end
      end
    end
    |> Enum.max()
  end

  def scenic_left(col_idx, row) do
    if col_idx > 0 do
      idx_height = Enum.at(row, col_idx)

      [count, _] =
        for t_idx <- (col_idx - 1)..0, reduce: [0, 0] do
          [count, tallest] ->
            t_height = Enum.at(row, t_idx)
            scenic_taller(idx_height, t_height, tallest, count)
        end

      count
    else
      0
    end
  end

  def scenic_right(col_idx, row) do
    row_length =
      row
      |> length

    if col_idx < row_length - 1 do
      idx_height = Enum.at(row, col_idx)

      [count, _] =
        for t_idx <- (col_idx + 1)..(row_length - 1), reduce: [0, 0] do
          [count, tallest] ->
            t_height = Enum.at(row, t_idx)
            scenic_taller(idx_height, t_height, tallest, count)
        end

      count
    else
      0
    end
  end

  def scenic_taller(idx_height, t_height, tallest, count) do
    if idx_height > tallest do
      if idx_height >= t_height do
        [count + 1, t_height]
      else
        [count + 1, t_height]
      end
    else
      [count, tallest]
    end
  end
end
