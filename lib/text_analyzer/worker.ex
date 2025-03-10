
defmodule TextAnalyzer.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def analyze(text) do
    words = String.split(text)
    total_words = length(words)
    unique_words = Enum.uniq(words)
    word_frequencies = count_word_frequencies(words)

    %{
      total_words: total_words,
      unique_words: unique_words,
      word_frequencies: word_frequencies
    }
  end

  defp count_word_frequencies(words) do
    words
    |> Enum.frequencies()
    |> Enum.to_list()
    |> Enum.sort_by(fn {_word, count} -> -count end)
  end
end
