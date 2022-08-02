package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformConnectorsExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/connectors",

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// website::tag::4:: Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2:: Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// website::tag::3:: Run `terraform output` to get the values of output variables and check they have the expected values.
	// actualKafkaTopic := terraform.Output(t, terraformOptions, "kafka_topic")
	// actualOtherKafkaTopic := terraform.Output(t, terraformOptions, "other_kafka_topic")

	// expectedKafkaTopic := "map[configs:map[cleanup.policy:delete] kafkaClusterRef:map[name:<nil> namespace:<nil>] kafkaRest:map[authentication:map[basic:map[debug:<nil> directoryPathInContainer:<nil> restrictedRoles:<nil> roles:<nil> secretRef:<nil>] bearer:map[directoryPathInContainer:<nil> secretRef:<nil>] type:<nil>] endpoint:<nil> kafkaClusterID:<nil> tls:map[directoryPathInContainer:<nil> jksPassword:map[secretRef:<nil>] secretRef:<nil>]] kafkaRestClassRef:map[name:<nil> namespace:<nil>] name:<nil> partitionCount:3 replicas:3]"
	// expectedOtherKafkaTopic := "map[configs:map[cleanup.policy:compact] kafkaClusterRef:map[name:<nil> namespace:<nil>] kafkaRest:map[authentication:map[basic:map[debug:<nil> directoryPathInContainer:<nil> restrictedRoles:<nil> roles:<nil> secretRef:<nil>] bearer:map[directoryPathInContainer:<nil> secretRef:<nil>] type:<nil>] endpoint:http://kafka.confluent.svc.cluster.local:8090 kafkaClusterID:<nil> tls:map[directoryPathInContainer:<nil> jksPassword:map[secretRef:<nil>] secretRef:<nil>]] kafkaRestClassRef:map[name:<nil> namespace:<nil>] name:<nil> partitionCount:4 replicas:3]"

	// assert.Equal(t, expectedKafkaTopic, actualKafkaTopic, "Map %q should match %q", expectedKafkaTopic, actualKafkaTopic)
	// assert.Equal(t, expectedOtherKafkaTopic, actualOtherKafkaTopic, "Map %q should match %q", expectedOtherKafkaTopic, actualOtherKafkaTopic)
}
