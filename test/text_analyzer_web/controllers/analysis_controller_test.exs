defmodule TextAnalyzerWeb.AnalysisControllerTest do
  use TextAnalyzerWeb.ConnCase

  test "POST /analyze_text", %{conn: conn} do
    conn = post(conn, "/analyze_text", %{"text" => "Elixir is great"})
    assert json_response(conn, 200)["status"] == "ok"
    assert json_response(conn, 200)["data"]["task_id"] != nil
  end

  test "GET /analysis_results", %{conn: conn} do
    conn = post(conn, "/analyze_text", %{"text" => "Elixir is great"})
    task_id = json_response(conn, 200)["data"]["task_id"]

    conn = get(conn, "/analysis_results", %{"task_id" => task_id})
    assert json_response(conn, 200)["status"] == "ok"
    assert json_response(conn, 200)["data"]["task_id"] == task_id
  end

  test "POST /tasks/:task_id/cancel", %{conn: conn} do
    conn = post(conn, "/analyze_text", %{"text" => "Elixir is great"})
    task_id = json_response(conn, 200)["data"]["task_id"]

    conn = post(conn, "/tasks/#{task_id}/cancel")
    assert json_response(conn, 200)["status"] == "ok"
    assert json_response(conn, 200)["data"]["status"] == "canceled"
  end

  test "GET /tasks", %{conn: conn} do
    conn = post(conn, "/analyze_text", %{"text" => "Elixir is great"})
    conn = get(conn, "/tasks")
    assert json_response(conn, 200)["status"] == "ok"
    assert length(json_response(conn, 200)["data"]["tasks"]) > 0
  end
end
