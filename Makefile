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

install-cfk-crds:
	# download the cfk helm chart
	curl -O https://confluent-for-kubernetes.s3-us-west-1.amazonaws.com/confluent-for-kubernetes-2.4.0.tar.gz
	mkdir -p confluent-for-kubernetes-2.4.0
	tar -xzf confluent-for-kubernetes-2.4.0.tar.gz --strip-components=1 -C confluent-for-kubernetes-2.4.0

	# install the cfk crds
	kubectl config set-cluster docker-desktop
	kubectl apply -f confluent-for-kubernetes-2.4.0/helm/confluent-for-kubernetes/crds/

setup: install-cfk-crds ## Setup project
	# terraform
	terraform init
	cd examples/confluent_operator && terraform init
	cd examples/confluent_platform && terraform init
	cd examples/confluent_platform_singlenode && terraform init
	cd examples/complete && terraform init

	# pre-commit
	git init
	git add -A
	pre-commit install

	# terratest
	go get github.com/gruntwork-io/terratest/modules/terraform
	go mod init test/terraform_confluent_operator_test.go
	go mod tidy -go=1.16 && go mod tidy -go=1.17

render-terraform-docs-code:
	# render terraform-docs code examples
	sed -z 's/source[^\r\n]*/source  = "aidanmelen\/confluent-platform\/kubernetes\/\/modules\/confluent_operator"\n  version = ">= 0.3.0"\n/g' examples/confluent_operator/main.tf > examples/confluent_operator/.main.tf.docs
	sed -z 's/source[^\r\n]*/source  = "aidanmelen\/confluent-platform\/kubernetes"\n  version = ">= 0.3.0"\n/g' examples/confluent_platform/main.tf > examples/confluent_platform/.main.tf.docs
	sed -z 's/source[^\r\n]*/source  = "aidanmelen\/confluent-platform\/kubernetes"\n  version = ">= 0.3.0"\n/g' examples/confluent_platform_singlenode/main.tf > examples/confluent_platform_singlenode/.main.tf.docs
	sed -z 's/source[^\r\n]*/source  = "aidanmelen\/confluent-platform\/kubernetes"\n  version = ">= 0.3.0"/g' examples/complete/main.tf > examples/complete/.main.tf.docs

lint:  ## Lint with pre-commit
	git add -A
	pre-commit run
	git add -A

lint-all: render-terraform-docs-code ## Lint with pre-commit
	git add -A
	pre-commit run --all-files
	git add -A

tests: test-confluent-operator test-confluent-platform-singlenode test-complete ## Tests with Terratest

test-confluent-operator: ## Test the confluent_operator example
	go test test/terraform_confluent_operator_test.go -timeout 5m -v |& tee test/terraform_confluent_operator_test.log

test-confluent-platform:
	go test test/terraform_confluent_platform_test.go -timeout 1h -v |& tee test/terraform_confluent_platform_test.log

test-confluent-platform-singlenode:
	go test test/terraform_confluent_platform_singlenode_test.go -timeout 20m -v |& tee test/terraform_confluent_platform_singlenode_test.log

test-setup:
	cd examples/confluent_operator && terraform apply --auto-approve

test-clean:
	cd examples/confluent_operator && terraform destroy --auto-approve

test-confluent-platform: test-setup test-confluent-platform test-clean ## Test the confluent_platform example

test-confluent-platform-singlenode: test-setup test-confluent-platform-singlenode test-clean ## Test the confluent_platform_singlenode example

test-complete: # Test the complete example
	go test test/terraform_complete_test.go -timeout 20m -v |& tee test/terraform_complete_test.log

uninstall-cfk-crds:
	# download the cfk helm chart
	curl -O https://confluent-for-kubernetes.s3-us-west-1.amazonaws.com/confluent-for-kubernetes-2.4.0.tar.gz
	mkdir confluent-for-kubernetes-2.4.0
	tar -xzf confluent-for-kubernetes-2.4.0.tar.gz --strip-components=1 -C confluent-for-kubernetes-2.4.0

	# install the cfk crds
	kubectl config set-cluster docker-desktop
	kubectl delete -f confluent-for-kubernetes-2.4.0/helm/confluent-for-kubernetes/crds/

	# clean up the cfk downloads
	rm confluent-for-kubernetes-2.4.0.tar.gz
	rm -rf confluent-for-kubernetes-2.4.0

clean: uninstall-cfk-crds ## Clean project
	@rm -f .terraform.lock.hcl
	@rm -f examples/confluent_operator/.terraform.lock.hcl
	@rm -f examples/confluent_platform/.terraform.lock.hcl
	@rm -f examples/confluent_platform_singlenode/.terraform.lock.hcl
	@rm -f examples/complete/.terraform.lock.hcl

	@rm -rf examples/confluent_operator/.terraform
	@rm -rf examples/confluent_platform/.terraform
	@rm -rf examples/confluent_platform_singlenode/.terraform
	@rm -f examples/complete/.terraform.terraform

	@rm -f go.mod
	@rm -f go.sum
	@rm -f test/go.mod
	@rm -f test/go.sum
