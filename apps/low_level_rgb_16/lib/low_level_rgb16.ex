defmodule LowLevelRgb16 do
  @moduledoc """
  see https://github.com/yuce/png/blob/master/examples/low_level_rgb_16.escript
  """

  import PngConfig, only: [png_config: 1]

  def main([]) do
    width = 100
    height = 100
    rows = make_rows(width, height)
    data = {:rows, rows}
    config = png_config(size: {width, height}, mode: {:rgb, 16})

    io_data = [
      :png.header(),
      :png.chunk(:IHDR, config),
      :png.chunk(:IDAT, data),
      :png.chunk(:IEND)
    ]

    :ok = File.write("low_level_rgb_16.png", io_data)
  end

  defp make_rows(width, height) do
    f = &make_row(&1, width, height)
    Enum.map(1..height, f)
  end

  defp make_row(y, width, height) do
    f = fn x ->
      r = trunc(x / width * 65535)
      b = trunc(y / height * 65535)
      <<r::16, 32768::16, b::16>>
    end

    Enum.map(1..width, f)
  end
end
