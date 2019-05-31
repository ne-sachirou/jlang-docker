default: help

.PHONY: help
help:
	@awk -F':.*##' '/^[-_a-zA-Z0-9]+:.*##/{printf"%-12s\t%s\n",$$1,$$2}' $(MAKEFILE_LIST) | sort

J_VERSION=807

.PHONY: build
build: ## Build
	ls "j$(J_VERSION)_amd64.deb" || wget "http://www.jsoftware.com/download/j$(J_VERSION)/install/j$(J_VERSION)_amd64.deb"
	docker build --pull --force-rm -t "nesachirou/jlang:$(J_VERSION)" --build-arg "J_VERSION=$(J_VERSION)" .
	docker tag "nesachirou/jlang:$(J_VERSION)" nesachirou/jlang:latest

.PHONY: publish
publish: ## Publish images to Docker Hub
	docker push "nesachirou/jlang:$(J_VERSION)"
	docker push nesachirou/jlang:latest

.PHONY: test
test: ## Test
	shellcheck Makefile || true
	yamllint ./.*.yaml ./*.yml
	hadolint Dockerfile
	container-structure-test test --image "nesachirou/jlang:$(J_VERSION)" --config container-structure-test.yml

.PHONY: run
run: ## Run ijconsole
	docker run -it -v "$(shell pwd):/data" nesachirou/jlang:latest "$(ARGS)"

.PHONY: sh
sh:
	docker exec -it "$(shell docker ps -q -f'ancestor=nesachirou/jlang')" bash
