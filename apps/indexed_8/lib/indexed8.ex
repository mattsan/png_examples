defmodule Indexed8 do
  @moduledoc """
  see https://github.com/yuce/png/blob/master/examples/indexed_8.escript
  """

  def main([]) do
    callback = &:io.format('Wrote: ~p~n', [&1])

    create(callback)
  end

  def main(["file"]) do
    File.open("indexed_8.png", [:write], fn file ->
      callback = &IO.binwrite(file, &1)

      create(callback)
    end)
  end

  def create(callback) do
    width = 100
    height = 100
    palette = {:rgb, 8, [{255, 0, 0}, {0, 255, 0}, {0, 0, 255}]}

    png =
      :png.create(%{
        size: {width, height},
        mode: {:indexed, 8},
        call: callback,
        palette: palette
      })

    :ok = append_rows(png)
    :ok = :png.close(png)

    :ok
  end

  defp append_rows(png) do
    append_row(png, 0)
  end

  defp append_row(%{size: {_, height}}, height) do
    :ok
  end

  defp append_row(%{size: {width, _height}} = png, y) do
    thickness = div(width, 4)

    f = fn
      x when x > y + thickness -> 2
      x when x + thickness < y -> 1
      _ -> 0
    end

    row = Enum.map(1..width, f)
    :png.append(png, {:row, row})
    append_row(png, y + 1)
  end
end
