package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformConfluentPlatformSinglenodeExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/quickstart_deploy/confluent_platform_singlenode",

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// website::tag::4:: Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2:: Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// website::tag::3:: Run `terraform output` to get the values of output variables and check they have the expected values.
	actualZookeeper := terraform.OutputMapOfObjects(t, terraformOptions, "zookeeper")
	actualKafka := terraform.OutputMapOfObjects(t, terraformOptions, "kafka")
	actualConnect := terraform.OutputMapOfObjects(t, terraformOptions, "connect")
	actualKsqlDB := terraform.OutputMapOfObjects(t, terraformOptions, "ksqldb")
	actualControlCenter := terraform.OutputMapOfObjects(t, terraformOptions, "control_center")
	actualSchemaRegistry := terraform.OutputMapOfObjects(t, terraformOptions, "schema_registry")
	actualKafkaRestProxy := terraform.OutputMapOfObjects(t, terraformOptions, "kafka_rest_proxy")

	expectedZookeeper := map[string]interface{}(map[string]interface{}{})
	expectedKafka := map[string]interface{}(map[string]interface{}{})
	expectedConnect := map[string]interface{}(map[string]interface{}{})
	expectedKsqlDB := map[string]interface{}(map[string]interface{}{})
	expectedControlCenter := map[string]interface{}(map[string]interface{}{})
	expectedSchemaRegistry := map[string]interface{}(map[string]interface{}{})
	expectedKafkaRestProxy := map[string]interface{}(map[string]interface{}{})

	assert.Equal(t, expectedZookeeper, actualZookeeper, "Map %q should match %q", expectedZookeeper, actualZookeeper)
	assert.Equal(t, expectedKafka, actualKafka, "Map %q should match %q", expectedKafka, actualKafka)
	assert.Equal(t, expectedConnect, actualConnect, "Map %q should match %q", expectedConnect, actualConnect)
	assert.Equal(t, expectedKsqlDB, actualKsqlDB, "Map %q should match %q", expectedKsqlDB, actualKsqlDB)
	assert.Equal(t, expectedControlCenter, actualControlCenter, "Map %q should match %q", expectedControlCenter, actualControlCenter)
	assert.Equal(t, expectedSchemaRegistry, actualSchemaRegistry, "Map %q should match %q", expectedSchemaRegistry, actualSchemaRegistry)
	assert.Equal(t, expectedKafkaRestProxy, actualKafkaRestProxy, "Map %q should match %q", expectedKafkaRestProxy, actualKafkaRestProxy)

	// website::tag::4:: Run a second "terraform apply". Fail the test if results have changes
	terraform.ApplyAndIdempotent(t, terraformOptions)
}
