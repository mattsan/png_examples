defmodule Grayscale8 do
  @moduledoc """
  see https://github.com/yuce/png/blob/master/examples/grayscale_8.escript
  """

  def main([]) do
    width = 100
    height = 100
    :random.seed()
    {:ok, file} = File.open("grayscale_8.png", [:write])

    png =
      :png.create(%{
        size: {width, height},
        mode: {:grayscale, 8},
        file: file
      })

    :ok = append_rows(png)
    :ok = :png.close(png)
    :ok = File.close(file)
  end

  defp append_rows(%{size: {_, height}} = png) do
    f = &append_row(png, &1)

    Enum.each(1..height, f)
  end

  defp append_row(%{size: {width, height}} = png, y) do
    f = &<<:random.uniform(trunc(255 * (&1 / width + y / height) / 2))>>

    row = Enum.map(1..width, f)
    :png.append(png, {:row, row})
  end
end
