
defmodule TextAnalyzer.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def analyze_text(text) do
    # Логика анализа текста
    # Возвращает результаты анализа
  end
end
