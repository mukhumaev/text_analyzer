defmodule TextAnalyzer.TaskManagerTest do
  use ExUnit.Case

  setup do
    :ets.new(:tasks, [:set, :public, :named_table])
    :ok
  end

  test "creates a new task" do
    assert {:ok, task_id} = GenServer.call(TextAnalyzer.TaskManager, {:create_task, "test text"})
    assert is_binary(task_id)
  end

  test "gets a task by id" do
    {:ok, task_id} = GenServer.call(TextAnalyzer.TaskManager, {:create_task, "test text"})
    assert {:ok, task} = GenServer.call(TextAnalyzer.TaskManager, {:get_task, task_id})
    assert task.status == :started
  end

  test "cancels a task" do
    {:ok, task_id} = GenServer.call(TextAnalyzer.TaskManager, {:create_task, "test text"})
    assert {:ok, task} = GenServer.call(TextAnalyzer.TaskManager, {:cancel_task, task_id})
    assert task.status == :canceled
  end

  test "lists all tasks" do
    {:ok, task_id} = GenServer.call(TextAnalyzer.TaskManager, {:create_task, "test text"})
    assert {:ok, tasks} = GenServer.call(TextAnalyzer.TaskManager, :list_tasks)
    assert length(tasks) == 1
  end
end
