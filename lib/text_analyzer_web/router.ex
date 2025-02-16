defmodule TextAnalyzerWeb.Router do
  use Plug.Router

  # Подключаем необходимые плагины
  plug :match
  plug :dispatch

  # Обработка запроса на анализ текста
  post "/analyze_text" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    case Jason.decode(body) do
      {:ok, %{"text" => text}} when is_binary(text) and text != "" ->
        task_id = UUID.uuid4()  # Генерация уникального ID задачи
        # Здесь вы можете добавить логику для отправки задачи на анализ
        send_resp(conn, 200, Jason.encode!(%{
          status: "ok",
          data: %{
            task_id: task_id,
            status: "started"
          }
        }))

      _ ->
        send_resp(conn, 400, Jason.encode!(%{
          status: "error",
          message: "Text field is empty or invalid."
        }))
    end
  end

  # Получение результатов анализа
  get "/analysis_results" do
    task_id = conn.params["task_id"]

    # Здесь вы можете добавить логику для получения результатов анализа по task_id
    # Пример успешного ответа:
    results = %{
      word_count: 12,
      frequency: %{"elixir" => 1, "is" => 1, "a" => 1},
      top_10_words: [%{"word" => "elixir", "count" => 1}, %{"word" => "is", "count" => 1}],
      unique_words: ["elixir", "dynamic", "functional"]
    }

    send_resp(conn, 200, Jason.encode!(%{
      status: "ok",
      data: %{
        task_id: task_id,
        status: "completed",
        results: results
      }
    }))
  end

  # Отмена задачи
  post "/tasks/:task_id/cancel" do
    task_id = conn.params["task_id"]

    # Здесь вы можете добавить логику для отмены задачи по task_id
    send_resp(conn, 200, Jason.encode!(%{
      status: "ok",
      data: %{
        task_id: task_id,
        status: "canceled"
      }
    }))
  end

  # Получение списка всех задач
  get "/tasks" do
    # Здесь вы можете добавить логику для получения списка задач
    tasks = [
      %{task_id: "6489afc4-3876-4c24-9242-d0b63b00181e", status: "completed"},
      %{task_id: "6489afc4-3876-4c24-9242-d0b63b00181d", status: "in_progress"}
    ]

    send_resp(conn, 200, Jason.encode!(%{
      status: "ok",
      data: %{
        tasks: tasks
      }
    }))
  end

  # Обработка несуществующих маршрутов
  match _ do
    send_resp(conn, 404, Jason.encode!(%{
      status: "error",
      message: "Not found."
    }))
  end
end
