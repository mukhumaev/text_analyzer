defmodule TextAnalyzerWeb.FallbackController do
  use TextAnalyzerWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> render("error.json", status: "NotFound", reason: "Not found")
  end
end
