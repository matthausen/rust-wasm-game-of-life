all: run

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-z0-9A-Z_-]+:.*?## / {printf "\033[36m%-45s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh \
	cargo install cargo-generate \
	npm install npm@latest -g

init:
	wasm-pack build \
	npm init wasm-app www \

dep:
	cd www/ && \
	npm install

build:
	wasm-pack build

run: 
	cd www/ && \
	npm run start

test:
	wasm-pack test --firefox --headless

opt:
	wasm-opt -Oz output.wasm input.wasm

.PHONY: setup init dep build run test opt