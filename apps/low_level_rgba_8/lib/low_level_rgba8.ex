defmodule LowLevelRgba8 do
  @moduledoc """
  see https://github.com/yuce/png/blob/master/examples/low_level_rgba_8.escript
  """

  import PngConfig, only: [png_config: 1]

  def main([]) do
    width = 50
    height = 50
    rows = make_rows(width, height)
    data = {:rows, rows}
    config = png_config(size: {width, height}, mode: {:rgba, 8})

    io_data = [
      :png.header(),
      :png.chunk(:IHDR, config),
      :png.chunk(:IDAT, data),
      :png.chunk(:IEND)
    ]

    :ok = File.write("low_level_rgba_8.png", io_data)
  end

  defp make_rows(width, height) do
    f = &make_row(&1, width, height)

    Enum.map(1..height, f)
  end

  defp make_row(y, width, height) do
    f = fn x ->
      r = trunc(x / width * 255)
      b = trunc(y / height * 255)
      a = trunc((x / width + y / height) / 2 * 255)
      <<r, 128, b, a>>
    end

    Enum.map(1..width, f)
  end
end
