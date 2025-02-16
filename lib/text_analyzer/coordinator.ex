defmodule TextAnalyzer.Coordinator do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    workers = for _ <- 1..5, do: TextAnalyzer.Worker.start_link()
    {:ok, %{workers: workers, tasks: %{}}}
  end

  def handle_call({:analyze, text}, _from, state) do
    # Логика распределения задач между воркерами
  end

  def handle_call({:cancel, task_id}, _from, state) do
    # Логика отмены задачи
  end

  def handle_call(:list_tasks, _from, state) do
    {:reply, Map.keys(state.tasks), state}
  end
end
