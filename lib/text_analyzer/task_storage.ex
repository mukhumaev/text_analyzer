defmodule TextAnalyzer.TaskStorage do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    :ets.new(:tasks, [:set, :protected, :named_table])
    {:ok, %{}}
  end

  def save_task(task_data) do
    task_id = generate_task_id()
    :ets.insert(:tasks, {:started, task_id, task_data})
    {:ok, {:started, task_id, task_data}}
  end

  def get_task(task_id) do
    case :ets.lookup(:tasks, task_id) do
      [{^task_id, task_data}] -> {:ok, task_data}
      [] -> {:error, :not_found}
    end
  end

  def list_tasks() do
    :ets.tab2list(:tasks)
  end

  # private

  defp generate_task_id do
    UUID.uuid4()
  end
end
