defmodule TextAnalyzer.WorkerTest do
  use ExUnit.Case

  test "analyzes text correctly" do
    text = "Elixir is great"
    results = GenServer.call(TextAnalyzer.Worker, {:analyze, text})
    assert results.word_count == 3
    assert results.frequency["Elixir"] == 1
    assert results.frequency["is"] == 1
    assert results.frequency["great"] == 1
  end
end
