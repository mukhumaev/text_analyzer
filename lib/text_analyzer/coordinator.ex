defmodule TextAnalyzer.Coordinator do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    {:ok, %{workers: [], current_index: 0}}
  end

  @impl true
  def handle_call({:assign_task, text}, _from, state) do
    worker = Enum.at(state.workers, state.current_index)
    new_index = rem(state.current_index + 1, length(state.workers))
    GenServer.call(worker, {:analyze, text})
    {:reply, :ok, %{state | current_index: new_index}}
  end
end
