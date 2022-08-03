package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformConnectorExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/connector",

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// website::tag::4:: Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2:: Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// website::tag::3:: Run `terraform output` to get the values of output variables and check they have the expected values.
	actualConnector := terraform.Output(t, terraformOptions, "connector")

	expectedConnector := "map[class:org.apache.kafka.connect.mirror.MirrorSourceConnector configs:map[source.cluster.alias:self source.cluster.bootstrap.servers:kafka:9092 target.cluster.bootstrap.servers:kafka:9092 topics:my-topic] connectClusterRef:map[name:connect namespace:<nil>] connectRest:map[authentication:map[basic:map[debug:<nil> directoryPathInContainer:<nil> restrictedRoles:<nil> roles:<nil> secretRef:<nil>] bearer:map[directoryPathInContainer:<nil> secretRef:<nil>] type:<nil>] endpoint:<nil> kafkaClusterID:<nil> tls:map[directoryPathInContainer:<nil> jksPassword:map[secretRef:<nil>] secretRef:<nil>]] name:<nil> restartPolicy:map[maxRetry:<nil> type:<nil>] taskMax:1]"

	assert.Equal(t, expectedConnector, actualConnector, "Map %q should match %q", expectedConnector, actualConnector)
}
