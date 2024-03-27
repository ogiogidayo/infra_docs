up: ## Do docker compose up with hot reload
	docker compose up -d

down: ## Do docker compose down
	docker compose down

shell: ## コンテナのシェルに一般ユーザーで接続
	docker compose exec server /bin/bash

root-shell: ## コンテナのシェルにrootユーザーで接続
	docker compose exec -u root server /bin/bash

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'