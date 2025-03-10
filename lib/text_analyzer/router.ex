defmodule TextAnalyzerWeb.Router do
  use TextAnalyzerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TextAnalyzerWeb do
    pipe_through :api

    post "/analyze_text", AnalysisController, :analyze
    get "/analysis_results", AnalysisController, :result
    post "/tasks/:task_id/cancel", AnalysisController, :cancel
    get "/tasks", AnalysisController, :tasks
  end
end
