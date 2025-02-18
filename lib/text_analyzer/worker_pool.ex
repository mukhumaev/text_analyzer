defmodule TextAnalyzer.WorkerPool do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    children = for i <- 1..5 do
      worker = {TextAnalyzer.Worker, []}
      Supervisor.child_spec(worker, id: "worker_#{i}")
    end

    Supervisor.init(children, strategy: :one_for_one)
  end
end
