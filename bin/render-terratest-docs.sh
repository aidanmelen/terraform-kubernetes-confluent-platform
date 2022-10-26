#!/bin/bash

# render terratest docs

VERSION=$1
TF_VERSION=$(cat .terraform-version)
echo "Terratest Suite (Module v${VERSION}) (Terraform v${TF_VERSION})" > test/.terratest.docs

tail -3 test/terraform_complete_test.log | head -1 >> test/.terratest.docs
tail -3 test/terraform_confluent_operator_test.log | head -1 >> test/.terratest.docs
tail -3 test/terraform_confluent_platform_test.log | head -1 >> test/.terratest.docs
tail -3 test/terraform_confluent_platform_singlenode_test.log | head -1 >> test/.terratest.docs
tail -3 test/terraform_connector_test.log | head -1 >> test/.terratest.docs
tail -3 test/terraform_kafka_topic_test.log | head -1 >> test/.terratest.docs
tail -3 test/terraform_schema_test.log | head -1 >> test/.terratest.docs
