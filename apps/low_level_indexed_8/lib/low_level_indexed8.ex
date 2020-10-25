defmodule LowLevelIndexed8 do
  @moduledoc """
  see https://github.com/yuce/png/blob/master/examples/low_level_indexed_8.escript
  """

  import PngConfig, only: [png_config: 1]

  def main([]) do
    bit_depth = 8
    palette = {:rgb, bit_depth, [{255, 0, 0}, {0, 255, 0}, {0, 0, 255}]}
    width = 50
    height = 50
    rows = make_rows(width, height, palette)
    data = {:rows, rows}
    config = png_config(size: {width, height}, mode: {:indexed, 8})

    io_data = [
      :png.header(),
      :png.chunk(:IHDR, config),
      :png.chunk(:PLTE, palette),
      :png.chunk(:IDAT, data),
      :png.chunk(:IEND)
    ]

    :ok = File.write("low_level_indexed_8.png", io_data)
  end

  def make_rows(width, height, {:rgb, _, colors}) do
    color_count = length(colors)
    f = &make_row(width, &1, color_count, 2)

    Enum.map(1..height, f)
  end

  def make_row(width, y, _color_count, _pix_size) do
    thickness = div(width, 4)

    f = fn
      x when x > y + thickness -> 2
      x when x + thickness < y -> 1
      _ -> 0
    end

    Enum.map(1..width, f)
  end
end
