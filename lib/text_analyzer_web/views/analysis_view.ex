defmodule TextAnalyzerWeb.AnalysisView do
  def render(_, %{request: data}) do
    %{
      status: "ok",
      data: %{
        task_id: data.task_id,
        status: data.status
      }
    }
  end
end
