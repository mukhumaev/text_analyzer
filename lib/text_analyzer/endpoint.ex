defmodule TextAnalyzerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :text_analyzer

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug(Plug.Static,
    at: "/",
    from: :text_analyzer,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)
  )

  plug(Plug.Logger)
  plug Plug.Telemetry, event_prefix: [:text_analyzer, :plug]

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  plug(Plug.RequestId)

  def init(_key, config) do
    {:ok, config}
  end
end
