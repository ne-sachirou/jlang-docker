default: help

.PHONY: help
help:
	@awk -F':.*##' '/^[-_a-zA-Z0-9]+:.*##/{printf"%-12s\t%s\n",$$1,$$2}' $(MAKEFILE_LIST) | sort

.PHONY: build
build: ## Build
	ls j807_amd64.deb || wget http://www.jsoftware.com/download/j807/install/j807_amd64.deb
	docker build -t nesachirou/jlang .

.PHONY: run
run: ## Run jconsole
	docker run -it -v $(shell pwd):/data nesachirou/jlang ${ARGS}

.PHONY: sh
sh:
	docker exec -it $(shell docker ps -q -f'ancestor=nesachirou/jlang') bash
