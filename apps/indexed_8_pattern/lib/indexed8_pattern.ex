defmodule Indexed8Pattern do
  @moduledoc """
  see https://github.com/yuce/png/blob/master/examples/indexed_8_pattern.escript
  """

  def main([]) do
    :random.seed()

    width = 30
    height = 30

    palette = {:rgb, 8, [{255, 0, 0}, {128, 255, 128}, {64, 64, 255}, {0, 0, 0}]}
    {:ok, file} = File.open("sample.png", [:write])

    png =
      :png.create(%{
        size: {width, height},
        mode: {:indexed, 8},
        file: file,
        palette: palette
      })

    append_row = fn _ ->
      row = Enum.map(1..width, fn _ -> :random.uniform(4) - 1 end)
      :png.append(png, {:row, row})
    end

    Enum.each(1..height, append_row)

    :ok = :png.close(png)
    :ok = File.close(file)
  end
end
