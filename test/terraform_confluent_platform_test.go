package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformConfluentPlatformExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/quickstart_deploy/confluent_platform",

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

	expectedZookeeper := map[string]interface{}(map[string]interface{}{"apiVersion": "platform.confluent.io/v1beta1", "kind": "Zookeeper", "metadata": map[string]interface{}{"name": "zookeeper", "namespace": "confluent"}, "spec": map[string]interface{}{"dataVolumeCapacity": "10Gi", "image": map[string]interface{}{"application": "confluentinc/cp-zookeeper:7.2.0", "init": "confluentinc/confluent-init-container:2.4.0"}, "logVolumeCapacity": "10Gi", "replicas": 3}})
	expectedKafka := map[string]interface{}(map[string]interface{}{"apiVersion": "platform.confluent.io/v1beta1", "kind": "Kafka", "metadata": map[string]interface{}{"name": "kafka", "namespace": "confluent"}, "spec": map[string]interface{}{"dataVolumeCapacity": "10Gi", "image": map[string]interface{}{"application": "confluentinc/cp-server:7.2.0", "init": "confluentinc/confluent-init-container:2.4.0"}, "metricReporter": map[string]interface{}{"enabled": true}, "replicas": 3}})
	expectedConnect := map[string]interface{}(map[string]interface{}{"apiVersion": "platform.confluent.io/v1beta1", "kind": "Connect", "metadata": map[string]interface{}{"name": "connect", "namespace": "confluent"}, "spec": map[string]interface{}{"dependencies": map[string]interface{}{"kafka": map[string]interface{}{"bootstrapEndpoint": "kafka:9071"}}, "image": map[string]interface{}{"application": "confluentinc/cp-server-connect:7.2.0", "init": "confluentinc/confluent-init-container:2.4.0"}, "replicas": 1}})
	expectedKsqlDB := map[string]interface{}(map[string]interface{}{"apiVersion": "platform.confluent.io/v1beta1", "kind": "KsqlDB", "metadata": map[string]interface{}{"name": "ksqldb", "namespace": "confluent"}, "spec": map[string]interface{}{"dataVolumeCapacity": "10Gi", "image": map[string]interface{}{"application": "confluentinc/cp-ksqldb-server:7.2.0", "init": "confluentinc/confluent-init-container:2.4.0"}, "replicas": 1}})
	expectedControlCenter := map[string]interface{}(map[string]interface{}{"apiVersion": "platform.confluent.io/v1beta1", "kind": "ControlCenter", "metadata": map[string]interface{}{"name": "controlcenter", "namespace": "confluent"}, "spec": map[string]interface{}{"dataVolumeCapacity": "10Gi", "dependencies": map[string]interface{}{"connect": []map[string]interface{}{map[string]interface{}{"name": "connect", "url": "http://connect.confluent.svc.cluster.local:8083"}}, "ksqldb": []map[string]interface{}{map[string]interface{}{"name": "ksqldb", "url": "http://ksqldb.confluent.svc.cluster.local:8088"}}, "schemaRegistry": map[string]interface{}{"url": "http://schemaregistry.confluent.svc.cluster.local:8081"}}, "image": map[string]interface{}{"application": "confluentinc/cp-enterprise-control-center:7.2.0", "init": "confluentinc/confluent-init-container:2.4.0"}, "replicas": 1}})
	expectedSchemaRegistry := map[string]interface{}(map[string]interface{}{"apiVersion": "platform.confluent.io/v1beta1", "kind": "SchemaRegistry", "metadata": map[string]interface{}{"name": "schemaregistry", "namespace": "confluent"}, "spec": map[string]interface{}{"image": map[string]interface{}{"application": "confluentinc/cp-schema-registry:7.2.0", "init": "confluentinc/confluent-init-container:2.4.0"}, "replicas": 3}})
	expectedKafkaRestProxy := map[string]interface{}(map[string]interface{}{"apiVersion": "platform.confluent.io/v1beta1", "kind": "KafkaRestProxy", "metadata": map[string]interface{}{"name": "kafkarestproxy", "namespace": "confluent"}, "spec": map[string]interface{}{"dependencies": map[string]interface{}{"schemaRegistry": map[string]interface{}{"url": "http://schemaregistry.confluent.svc.cluster.local:8081"}}, "image": map[string]interface{}{"application": "confluentinc/cp-kafka-rest:7.2.0", "init": "confluentinc/confluent-init-container:2.4.0"}, "replicas": 1}})

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
