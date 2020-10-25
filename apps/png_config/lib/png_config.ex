defmodule PngConfig do
  require Record

  Record.defrecord(:png_config,
    size: {0, 0},
    mode: {:grayscale, 8},
    compression_method: 0,
    filter_method: 0,
    interlace_method: 0
  )
end
