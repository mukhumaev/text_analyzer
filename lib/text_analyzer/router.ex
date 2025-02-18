defmodule TextAnalyzerWeb.Router do
  use TextAnalyzerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TextAnalyzerWeb do
    pipe_through :api

    # Маршруты для анализа текста
    post "/analyze_text", AnalysisController, :analyze_text
    get "/analysis_results", AnalysisController, :get_results
    post "/tasks/:task_id/cancel", AnalysisController, :cancel_task
    get "/tasks", AnalysisController, :list_tasks
  end
end
