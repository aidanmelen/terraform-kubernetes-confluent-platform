package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformConfluentOperatorExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/confluent_operator",

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// website::tag::4:: Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2:: Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// website::tag::3:: Run `terraform output` to get the values of output variables and check they have the expected values.
	actualAppVersion := terraform.Output(t, terraformOptions, "app_version")
	actualChartVersion := terraform.Output(t, terraformOptions, "chart_version")
	actualConfluentPlatformVersionCompatibilities := terraform.OutputList(t, terraformOptions, "confluent_platform_version_compatibilities")

	expectedAppVersion := "2.4.0"
	expectedChartVersion := "0.517.12"
	expectedConfluentPlatformVersionCompatibilities := []string([]string{"7.1.0", "7.2.0"})

	assert.Equal(t, expectedAppVersion, actualAppVersion, "Map %q should match %q", expectedAppVersion, actualAppVersion)
	assert.Equal(t, expectedChartVersion, actualChartVersion, "Map %q should match %q", expectedChartVersion, actualChartVersion)
	assert.Equal(t, expectedConfluentPlatformVersionCompatibilities, actualConfluentPlatformVersionCompatibilities, "Map %q should match %q",
		expectedConfluentPlatformVersionCompatibilities, actualConfluentPlatformVersionCompatibilities)

	// website::tag::4:: Run a second "terraform apply". Fail the test if results have changes
	terraform.ApplyAndIdempotent(t, terraformOptions)
}
