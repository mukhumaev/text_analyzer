defmodule TextAnalyzer.Task do
  use Vex.Struct

  def create(params) do
    with :ok <- validate_request(params) do
      build_request(params)
    else
      {:error, {status, reason}} ->
        {:error, {status, reason}}
    end
  end

  defp build_request(params), do: TaskStorage.save_task(params)

  defp validate_request(params) do
    case Vex.validate(params, [
      text: [presence: true],
      length: [min: 1]
    ]) do
      :ok -> :ok
      errors -> {:error, {400, errors}}
    end
  end
end
