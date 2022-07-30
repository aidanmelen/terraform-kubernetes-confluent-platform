package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformCompleteExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/complete",

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// website::tag::4:: Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2:: Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// website::tag::3:: Run `terraform output` to get the values of output variables and check they have the expected values.
	actualZookeeper := terraform.Output(t, terraformOptions, "zookeeper")
	actualKafka := terraform.Output(t, terraformOptions, "kafka")

	expectedZookeeper := "map[apiVersion:platform.confluent.io/v1beta1 kind:Zookeeper metadata:map[name:zookeeper namespace:confluent] spec:map[dataVolumeCapacity:10Gi image:map[application:confluentinc/cp-zookeeper:7.2.0 init:confluentinc/confluent-init-container:2.4.0] logVolumeCapacity:10Gi replicas:3]]"
	expectedKafka := "map[apiVersion:platform.confluent.io/v1beta1 kind:Kafka metadata:map[name:kafka namespace:confluent] spec:map[dataVolumeCapacity:10Gi image:map[application:confluentinc/cp-server:7.2.0 init:confluentinc/confluent-init-container:2.4.0] metricReporter:map[enabled:true] replicas:3]]"

	assert.Equal(t, expectedZookeeper, actualZookeeper, "Map %q should match %q", expectedZookeeper, actualZookeeper)
	assert.Equal(t, expectedKafka, actualKafka, "Map %q should match %q", expectedKafka, actualKafka)
}
