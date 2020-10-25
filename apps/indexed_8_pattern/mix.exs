defmodule Indexed8Pattern.MixProject do
  use Mix.Project

  def project do
    [
      app: :indexed_8_pattern,
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
      main_module: Indexed8Pattern
    ]
  end

  defp deps do
    [
      {:png, "~> 0.2"}
    ]
  end
end
