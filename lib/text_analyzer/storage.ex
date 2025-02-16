defmodule TextAnalyzer.Storage do
  def start_link do
    :ets.new(:analysis_results, [:public, :named_table])
  end

  def store_result(task_id, result) do
    :ets.insert(:analysis_results, {task_id, result})
  end

  def get_result(task_id) do
    case :ets.lookup(:analysis_results, task_id) do
      [] -> {:error, :not_found}
      [{^task_id, result}] -> {:ok, result}
    end
  end
end
