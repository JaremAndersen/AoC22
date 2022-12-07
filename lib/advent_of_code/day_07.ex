defmodule AdventOfCode.Day07 do
  def part1(input) do
    input
    |> Enum.reduce(["", %{}], fn command, [path, folders] ->
      [dir, folders] = process(command, path, folders)
      [dir, folders]
    end)
    |> Enum.at(1)
    |> Enum.reduce(0, fn {_dir, size}, acc ->
      if size <= 100_000 do
        acc + size
      else
        acc
      end
    end)
  end

  def process(command, dir \\ %{}, folders)

  def process(["cd /" <> _path], _dir, _folders) do
    ["/", %{"/" => 0}]
  end

  def process(["cd .." <> _path], dir, folders) do
    path_list = String.split(dir, "/")
    dir_depth = path_list |> length
    new_dir = (Enum.slice(path_list, 0, dir_depth - 2) |> Enum.join("/")) <> "/"
    [new_dir, folders]
  end

  def process(["cd " <> path], dir, folders) do
    new_folders = Map.update(folders, dir <> path <> "/", 0, fn existing -> existing end)
    [dir <> path <> "/", new_folders]
  end

  def process(["ls" | rest], current_dir, folders) do
    new_folders =
      rest
      |> Enum.reduce(folders, fn cmd, updated_folders ->
        case process_ls(cmd) do
          size when is_integer(size) ->
            updated_folders
            |> Enum.reduce(updated_folders, fn {folder, _value}, folders_with_updated_size ->
              if String.contains?(current_dir, folder) do
                Map.update!(folders_with_updated_size, folder, fn existing_size ->
                  existing_size + size
                end)
              else
                folders_with_updated_size
              end
            end)

          folder ->
            Map.update(updated_folders, current_dir <> folder <> "/", 0, fn _existing -> "wtf" end)
        end
      end)

    [current_dir, new_folders]
  end

  def process_ls("dir " <> folder) do
    folder
  end

  def process_ls(file) do
    [size, _filename] = String.split(file, " ", trim: true)
    String.to_integer(size)
  end

  def part2(input) do
    folders =
      input
      |> Enum.reduce(["", %{}], fn command, [path, folders] ->
        [dir, folders] = process(command, path, folders)
        [dir, folders]
      end)
      |> Enum.at(1)

    total = 70_000_000
    used = Map.get(folders, "/")
    available = total - used
    update_size = 30_000_000
    need_to_free = update_size - available

    folders
    |> Enum.reduce(999_999_999, fn {_folder, size}, to_remove ->
      if size > need_to_free and size < to_remove do
        size
      else
        to_remove
      end
    end)
  end
end
