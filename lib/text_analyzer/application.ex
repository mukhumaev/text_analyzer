defmodule TextAnalyzer.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {TextAnalyzer.Coordinator, []},
      {TextAnalyzer.WorkerPool, []},
      {TextAnalyzer.TaskStorage, []},
      {TextAnalyzerWeb.Endpoint, config()}
    ]

    opts = [strategy: :one_for_one, name: TextAnalyzer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp config(), do:
    Application.fetch_env!(:text_analyzer, TextAnalyzerWeb.Endpoint)
end
