
.DEFAULT_GOAL := start
.PHONY = start build run clean help

################################################################################

start: build run ## Build docker image and start container

build: ## Build docker image
	docker build . --tag text_analyzer -f Dockerfile

run: build ## Start docker container
	docker run --rm -p 4000:4000 text_analyzer

clean: ## Remove docker image and container
	docker container rm -f text_analyzer
	docker image rm text_analyzer

ft: ## fast test
	@docker run -it --rm -e MIX_ENV=prod \
				-p 127.0.0.1:4000:4000 \
				-w /app \
				-v ./:/app elixir:1.18-otp-27 \
				bash -c 'mix deps.get && mix compile && yes | mix release && echo +++++++++START+++++++++ && /app/_build/$${MIX_ENV}/rel/text_analyzer/bin/text_analyzer start'

iex: ## fast test iex
	@docker run -it --rm -e MIX_ENV=prod \
				-p 127.0.0.1:4000:4000 \
				-w /app \
				-v ./:/app elixir:1.18-otp-27 \
				bash -c '/app/_build/$${MIX_ENV}/rel/text_analyzer/bin/text_analyzer start_iex'

help: ## Show this info
	@echo -e '\n\033[1mSupported targets:\033[0m\n'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[33m%-12s\033[0m %s\n", $$1, $$2}'
	@echo -e ''

################################################################################
