defmodule TextAnalyzerWeb.ErrorView do
  def render("error.json", %{status: status, message: message}) do
    %{
      status: status,
      message: reason
    }
  end

  def render("500.json", _assigns) do
    %{
      status: "InternalServerError",
      reason: "Something went wrong"
    }
  end

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
