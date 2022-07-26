NAME = terraform-kubernetes-confluent

SHELL := /bin/bash

.PHONY: help all

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build docker dev container
	cd .devcontainer && docker build -f Dockerfile . -t $(NAME)

run: ## Run docker dev container
	docker run -it --rm -v "$$(pwd)":/workspaces/$(NAME) -v ~/.kube:/root/.kube -v ~/.cache/pre-commit:/root/.cache/pre-commit -v ~/.terraform.d/plugins:/root/.terraform.d/plugins --workdir /workspaces/$(NAME) $(NAME) /bin/bash

install: ## Install project
	# terraform
	terraform init
	cd examples/confluent_operator && terraform init
	cd examples/quickstart_deploy/confluent_platform && terraform init
	cd examples/quickstart_deploy/confluent_platform_singlenode && terraform init

	# terratest
	go get github.com/gruntwork-io/terratest/modules/terraform
	go mod init test/terraform_confluent_operator_test.go

	# pre-commit
	git init
	git add -A
	pre-commit install

lint:  ## Lint with pre-commit
	git add -A
	pre-commit run
	git add -A

lint-all:  ## Lint with pre-commit
	git add -A
	pre-commit run --all-files
	git add -A

tests: test-confluent-operator test-confluent-platform test-confluent-platform-singlenode  ## Test with Terratest

test-confluent-operator: ## Test confluent_operator Example
	go test test/terraform_confluent_operator_test.go -timeout 5m -v |& tee test/terraform_confluent_operator_test.log

test-confluent-platform: ## Test confluent_platform Example
	go test test/terraform_confluent_platform_test.go -timeout 30m -v |& tee test/terraform_confluent_platform_test.log

test-confluent-platform-singlenode: ## Test confluent_platform_singlenode Example
	go test test/terraform_confluent_platform_singlenode_test.go -timeout 20m -v |& tee test/terraform_confluent_platform_singlenode_test.log

clean: ## Clean project
	@rm -f .terraform.lock.hcl
	@rm -f examples/quickstart_deploy/confluent_platform/.terraform.lock.hcl
	@rm -f examples/quickstart_deploy/confluent_platform_singlenode/.terraform.lock.hcl
	@rm -f examples/confluent_operator/.terraform.lock.hcl

	@rm -rf .terraform*
	@rm -rf examples/quickstart_deploy/confluent_platform/.terraform
	@rm -rf examples/quickstart_deploy/confluent_platform_singlenode/.terraform
	@rm -rf examples/confluent_operator/.terraform

	@rm -f go.mod
	@rm -f go.sum
	@rm -f test/go.mod
	@rm -f test/go.sum
