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

apply-cfk-crds:
	kubectl config set-cluster docker-desktop
	kubectl apply -f ./crds/2.4.0

setup: apply-cfk-crds ## Setup project
	# terraform
	terraform init
	cd modules/confluent_operator && terraform init
	cd modules/kafka_topic && terraform init
	cd modules/connector && terraform init
	cd modules/schema && terraform init
	cd examples/confluent_operator && terraform init
	cd examples/confluent_platform && terraform init
	cd examples/confluent_platform_singlenode && terraform init
	cd examples/complete && terraform init
	cd examples/kafka_topic && terraform init
	cd examples/connector && terraform init
	cd examples/schema && terraform init

	# pre-commit
	git init
	git add -A
	pre-commit install

	# terratest
	rm -rf go.mod*
	go get github.com/gruntwork-io/terratest/modules/terraform
	go mod init test/terraform_confluent_operator_test.go
	go mod tidy -go=1.16 && go mod tidy -go=1.17

docs:
	./bin/render-docs.sh

lint: docs ## Lint with pre-commit
	git add -A
	pre-commit run
	git add -A

lint-all: docs ## Lint all files with pre-commit
	git add -A
	pre-commit run --all-files
	git add -A

tests: test-confluent-operator test-confluent-platform test-confluent-platform-singlenode test-complete test-kafka-topic test-schema test-connector ## Tests with Terratest

test-confluent-operator: ## Test the confluent_operator example
	go test test/terraform_confluent_operator_test.go -timeout 5m -v |& tee test/terraform_confluent_operator_test.log

test-setup:
	cd examples/confluent_operator && terraform apply --auto-approve

test-clean:
	cd examples/confluent_operator && terraform destroy --auto-approve

_test-confluent-platform:
	# This test can take longer because controlcenter takes a while to become healthy
	go test test/terraform_confluent_platform_test.go -timeout 10m -v |& tee test/terraform_confluent_platform_test.log

_test-confluent-platform-singlenode:
	go test test/terraform_confluent_platform_singlenode_test.go -timeout 10m -v |& tee test/terraform_confluent_platform_singlenode_test.log

test-confluent-platform: test-setup _test-confluent-platform test-clean ## Test the confluent_platform example

test-confluent-platform-singlenode: test-setup _test-confluent-platform-singlenode test-clean ## Test the confluent_platform_singlenode example

test-complete: ## Test the complete example
	go test test/terraform_complete_test.go -timeout 10m -v |& tee test/terraform_complete_test.log

test-kafka-topic: ## Test the kafka_topic example
	go test test/terraform_kafka_topic_test.go -timeout 10m -v |& tee test/terraform_kafka_topic_test.log

test-schema: ## Test the schema example
	go test test/terraform_schema_test.go -timeout 10m -v |& tee test/terraform_schema_test.log

test-connector: ## Test the connector example
	go test test/terraform_connector_test.go -timeout 10m -v |& tee test/terraform_connector_test.log

delete-cfk-crds:
	kubectl config set-cluster docker-desktop
	kubectl delete -f ./crds/2.4.0

clean: delete-cfk-crds ## Clean project
	@rm -f .terraform.lock.hcl
	@rm -f modules/confluent_operator/.terraform.lock.hcl
	@rm -f modules/kafka_topic/.terraform.lock.hcl
	@rm -f modules/connector/.terraform.lock.hcl
	@rm -f modules/schema/.terraform.lock.hcl
	@rm -f examples/confluent_operator/.terraform.lock.hcl
	@rm -f examples/confluent_platform/.terraform.lock.hcl
	@rm -f examples/confluent_platform_singlenode/.terraform.lock.hcl
	@rm -f examples/complete/.terraform.lock.hcl
	@rm -rf examples/kafka_topic/.terraform.lock.hcl
	@rm -rf examples/connector/.terraform.lock.hcl
	@rm -rf examples/schema/.terraform.lock.hcl

	@rm -rf .terraform
	@rm -rf modules/confluent_operator/.terraform
	@rm -rf modules/kafka_topic/.terraform
	@rm -rf modules/connector/.terraform
	@rm -rf modules/schema/.terraform
	@rm -rf examples/confluent_operator/.terraform
	@rm -rf examples/confluent_platform/.terraform
	@rm -rf examples/confluent_platform_singlenode/.terraform
	@rm -rf examples/complete/.terraform
	@rm -rf examples/kafka_topic/.terraform
	@rm -rf examples/connector/.terraform
	@rm -rf examples/schema/.terraform

	@rm -f go.mod
	@rm -f go.sum
	@rm -f test/go.mod
	@rm -f test/go.sum
