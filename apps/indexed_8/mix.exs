defmodule Indexed8.MixProject do
  use Mix.Project

  def project do
    [
      app: :indexed_8,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      escript: escript(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def escript do
    [
      main_module: Indexed8
    ]
  end

  defp deps do
    [
      {:png, "~> 0.2"}
    ]
  end
end
