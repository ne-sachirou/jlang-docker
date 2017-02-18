.PHONY: help build run
default: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .' $(MAKEFILE_LIST) | sort | awk -F ':.*?## ' '{printf "%s\t\t\t%s\n",$$1,$$2}'

build: ## Build
	ls j805_amd64.deb || wget http://www.jsoftware.com/download/j805/install/j805_amd64.deb
	docker build -t jlang .

run: ## Run jconsole
	docker run -it jlang
