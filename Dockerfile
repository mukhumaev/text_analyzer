FROM elixir:1.18-otp-27

COPY . /app

WORKDIR /app

RUN mix deps.get && mix compile && mix release

EXPOSE 4000

ENV MIX_ENV=prod

CMD ["/app/_build/dev/rel/text_analyzer/bin/text_analyzer", "start"]
