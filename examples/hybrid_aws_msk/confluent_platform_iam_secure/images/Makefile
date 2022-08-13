SHELL := /bin/bash

.PHONY: help all

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build docker images
	docker build -f Dockerfile.connect . -t cp-server-connect-with-aws-msk-iam-auth
	docker build -f Dockerfile.ksqldb . -t cp-ksqldb-server-with-aws-msk-iam-auth
	docker build -f Dockerfile.controlcenter . -t cp-enterprise-control-center-with-aws-msk-iam-auth
	docker build -f Dockerfile.schemaregistry . -t cp-schema-registry-with-aws-msk-iam-auth
	docker build -f Dockerfile.kafkarestproxy . -t cp-kafka-rest-with-aws-msk-iam-auth

	docker tag cp-server-connect-with-aws-msk-iam-auth aidanmelen/cp-server-connect-with-aws-msk-iam-auth:7.2.0
	docker tag cp-ksqldb-server-with-aws-msk-iam-auth aidanmelen/cp-ksqldb-server-with-aws-msk-iam-auth:7.2.0
	docker tag cp-enterprise-control-center-with-aws-msk-iam-auth aidanmelen/cp-enterprise-control-center-with-aws-msk-iam-auth:7.2.0
	docker tag cp-schema-registry-with-aws-msk-iam-auth aidanmelen/cp-schema-registry-with-aws-msk-iam-auth:7.2.0
	docker tag cp-kafka-rest-with-aws-msk-iam-auth aidanmelen/cp-kafka-rest-with-aws-msk-iam-auth:7.2.0

push: build ## Push docker images
	docker push aidanmelen/cp-server-connect-with-aws-msk-iam-auth:7.2.0
	docker push aidanmelen/cp-ksqldb-server-with-aws-msk-iam-auth:7.2.0
	docker push aidanmelen/cp-enterprise-control-center-with-aws-msk-iam-auth:7.2.0
	docker push aidanmelen/cp-schema-registry-with-aws-msk-iam-auth:7.2.0
	docker push aidanmelen/cp-kafka-rest-with-aws-msk-iam-auth:7.2.0
