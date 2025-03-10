defmodule TextAnalyzerWeb.AnalysisController do
  use TextAnalyzerWeb, :controller

  action_fallback TextAnalyzerWeb.FallbackController

  # post "/analyze_text", AnalysisController, :analyze
  # get "/analysis_results", AnalysisController, :result
  # post "/tasks/:task_id/cancel", AnalysisController, :cancel
  # get "/tasks", AnalysisController, :tasks

  def analyze(conn, request_params) do
    request_params
    |> Task.create()
    |> case do
      {:ok, %{} = task} ->
        render(conn, "create.json", data: task)
      {:error, {status, message}} ->
        render_error(conn, status, message)
    end
  end

  # def result(conn, request_params) do
  #   request_params
  #   |> Task.result()
  #   |> case do
  #     {:ok, %{} = task} ->
  #       render(conn, "result.json", data: task)
  #     {:error, {status, message}} ->
  #       render_error(conn, status, message)
  #   end
  # end

  # def cancel(conn, request_params) do
  #   request_params
  #   |> Task.cancel()
  #   |> case do
  #     {:ok, %{} = task} ->
  #       render(conn, "cancel.json", data: task)
  #     {:error, {status, message}} ->
  #       render_error(conn, status, message)
  #   end
  # end
  # def tasks(conn, request_params) do
  #   request_params
  #   |> Task.all()
  #   |> case do
  #     {:ok, %{} = task} ->
  #       render(conn, "tasks.json", data: task)
  #     {:error, {status, message}} ->
  #       render_error(conn, status, message)
  #   end
  # end

  defp render_error(conn, status, message) do
    conn
    |> put_view(ErrorView)
    |> render("error.json", status: status, message: message)
  end
end
