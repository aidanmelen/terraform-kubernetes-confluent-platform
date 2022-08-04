package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformSchemaExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/schema",

		Vars: map[string]interface{}{
			"create_controlcenter": false, // make test faster
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// website::tag::4:: Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2:: Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// website::tag::3:: Run `terraform output` to get the values of output variables and check they have the expected values.
	actualSchemaObjectSpec := terraform.Output(t, terraformOptions, "schema_object_spec")
	actualSchemaConfigMapData := terraform.Output(t, terraformOptions, "schema_config_map_data")

	expectedSchemaObjectSpec := "map[compatibilityLevel:<nil> data:map[configRef:pageviews-value-config format:avro] name:<nil> schemaReferences:<nil> schemaRegistryClusterRef:map[name:<nil> namespace:<nil>] schemaRegistryRest:map[authentication:map[basic:map[debug:<nil> directoryPathInContainer:<nil> restrictedRoles:<nil> roles:<nil> secretRef:<nil>] bearer:map[directoryPathInContainer:<nil> secretRef:<nil>] type:<nil>] endpoint:<nil> kafkaClusterID:<nil> tls:map[directoryPathInContainer:<nil> jksPassword:map[secretRef:<nil>] secretRef:<nil>]]]"
	expectedSchemaConfigMapData := "{\"schema\":\"{\\n  \\\"connect.name\\\": \\\"ksql.pageviews\\\",\\n  \\\"fields\\\": [\\n    {\\n      \\\"name\\\": \\\"viewtime\\\",\\n      \\\"type\\\": \\\"long\\\"\\n    },\\n    {\\n      \\\"name\\\": \\\"userid\\\",\\n      \\\"type\\\": \\\"string\\\"\\n    },\\n    {\\n      \\\"name\\\": \\\"pageid\\\",\\n      \\\"type\\\": \\\"string\\\"\\n    }\\n  ],\\n  \\\"name\\\": \\\"pageviews\\\",\\n  \\\"namespace\\\": \\\"ksql\\\",\\n  \\\"type\\\": \\\"record\\\"\\n}\\n\"}"

	assert.Equal(t, expectedSchemaObjectSpec, actualSchemaObjectSpec, "Map %q should match %q", expectedSchemaObjectSpec, actualSchemaObjectSpec)
	assert.Equal(t, expectedSchemaConfigMapData, actualSchemaConfigMapData, "Map %q should match %q", expectedSchemaConfigMapData, actualSchemaConfigMapData)
}
