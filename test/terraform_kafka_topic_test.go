package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformKafkaTopicExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/kafka_topic",

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// website::tag::4:: Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2:: Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// website::tag::3:: Run `terraform output` to get the values of output variables and check they have the expected values.
	actualKafkaTopic := terraform.Output(t, terraformOptions, "kafka_topic_manifest")

	expectedKafkaTopic := "map[apiVersion:platform.confluent.io/v1beta1 kind:KafkaTopic metadata:map[name:my-topic namespace:confluent] spec:map[configs:map[cleanup.policy:delete] partitionCount:3 replicas:3]]"

	assert.Equal(t, expectedKafkaTopic, actualKafkaTopic, "Map %q should match %q", expectedKafkaTopic, actualKafkaTopic)
}
