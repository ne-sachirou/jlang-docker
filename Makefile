.PHONY: help
help:
	@awk -F':.*##' '/^[-_a-zA-Z0-9]+:.*##/{printf"%-12s\t%s\n",$$1,$$2}' $(MAKEFILE_LIST) | sort

J_VERSION=901

.PHONY: build
build: ## Build
	DOCKER_BUILDKIT=1 docker build --pull --force-rm -t "nesachirou/jlang:$(J_VERSION)" -t nesachirou/jlang:latest --build-arg BUILDKIT_INLINE_CACHE=1 --build-arg "J_VERSION=$(J_VERSION)" .

.PHONY: publish
publish: ## Publish images to Docker Hub
	docker push "nesachirou/jlang:$(J_VERSION)"
	docker push nesachirou/jlang:latest

.PHONY: test
test: ## Test
	shellcheck Makefile || true
	yamllint .yamllint ./.*.yaml ./*.yml
	hadolint Dockerfile
	ls .github/workflows/*.yml | xargs -t ./lint-github-actions.rb
	container-structure-test test --image "nesachirou/jlang:$(J_VERSION)" --config container-structure-test.yml

.PHONY: run
run: ## Run ijconsole
	docker run -it -v "$(shell pwd):/data" nesachirou/jlang:latest "$(ARGS)"

.PHONY: sh
sh:
	docker exec -it "$(shell docker ps -q -f'ancestor=nesachirou/jlang')" bash
