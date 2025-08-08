defmodule Mix.Tasks.Benchmarks do
  @shortdoc "Run the Chorex benchmarks in full"
  @requirements ["loadpaths", "app.config", "app.start"]
  use Mix.Task

  def run(_args) do
    ChorexBenchmarks.stats()
  end
end
