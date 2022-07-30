NAME = terraform-kubernetes-confluent
VERSION = 0.3.1

SHELL := /bin/bash

.PHONY: help all

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build docker dev container
	cd .devcontainer && docker build -f Dockerfile . -t $(NAME)

run: ## Run docker dev container
	docker run -it --rm -v "$$(pwd)":/workspaces/$(NAME) -v ~/.kube:/root/.kube -v ~/.cache/pre-commit:/root/.cache/pre-commit -v ~/.terraform.d/plugins:/root/.terraform.d/plugins --workdir /workspaces/$(NAME) $(NAME) /bin/bash

setup: ## Setup project
	# terraform
	terraform init
	cd examples/confluent_operator && terraform init
	cd examples/confluent_platform && terraform init
	cd examples/confluent_platform_singlenode && terraform init
	cd examples/pre_existing_crds && terraform init

	# terratest
	go get github.com/gruntwork-io/terratest/modules/terraform
	go mod init test/terraform_confluent_operator_test.go

	# pre-commit
	git init
	git add -A
	pre-commit install

render-terraform-docs-code:
	# render terraform code examples
	sed -z 's/source[^\r\n]*/source  = "aidanmelen\/confluent-platform\/kubernetes\/\/modules\/confluent_operator"\n  version = ">= 0.3.0"\n/g' examples/confluent_operator/main.tf > examples/confluent_operator/.main.tf.docs
	sed -z 's/source[^\r\n]*/source  = "aidanmelen\/confluent-platform\/kubernetes"\n  version = ">= 0.3.0"\n/g' examples/confluent_platform/main.tf > examples/confluent_platform/.main.tf.docs
	sed -z 's/source[^\r\n]*/source  = "aidanmelen\/confluent-platform\/kubernetes"\n  version = ">= 0.3.0"\n/g' examples/confluent_platform_singlenode/main.tf > examples/confluent_platform_singlenode/.main.tf.docs
	sed -z 's/source[^\r\n]*/source  = "aidanmelen\/confluent-platform\/kubernetes"\n  version = ">= 0.3.0"/g' examples/pre_existing_crds/main.tf > examples/pre_existing_crds/.main.tf.docs

lint:  ## Lint with pre-commit
	git add -A
	pre-commit run
	git add -A

lint-all:  ## Lint with pre-commit
	git add -A
	pre-commit run --all-files
	git add -A

tests: test-confluent-operator test-confluent-platform test-confluent-platform-singlenode  ## Tests with Terratest

test-confluent-operator: ## Test the confluent_operator example
	go test test/terraform_confluent_operator_test.go -timeout 5m -v |& tee test/terraform_confluent_operator_test.log

_test-confluent-platform:
	go test test/terraform_confluent_platform_test.go -timeout 1h -v |& tee test/terraform_confluent_platform_test.log

_test-confluent-platform-singlenode:
	go test test/terraform_confluent_platform_singlenode_test.go -timeout 20m -v |& tee test/terraform_confluent_platform_singlenode_test.log

_test-setup:
	cd examples/confluent_operator && terraform apply --auto-approve

_test-clean:
	cd examples/confluent_operator && terraform destroy --auto-approve

test-confluent-platform: _test-setup _test-confluent-platform _test-clean ## Test the confluent_platform example

test-confluent-platform-singlenode: _test-setup _test-confluent-platform-singlenode _test-clean ## Test the confluent_platform_singlenode example

clean: ## Clean project
	@rm -f .terraform.lock.hcl
	@rm -f examples/confluent_platform/.terraform.lock.hcl
	@rm -f examples/confluent_platform_singlenode/.terraform.lock.hcl
	@rm -f examples/confluent_operator/.terraform.lock.hcl

	@rm -rf .terraform*
	@rm -rf examples/confluent_platform/.terraform
	@rm -rf examples/confluent_platform_singlenode/.terraform
	@rm -rf examples/confluent_operator/.terraform

	@rm -f go.mod
	@rm -f go.sum
	@rm -f test/go.mod
	@rm -f test/go.sum
