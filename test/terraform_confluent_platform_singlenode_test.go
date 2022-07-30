package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformConfluentPlatformSinglenodeExample(t *testing.T) {
	terraformOptions := &terraform.Options{
		// website::tag::1:: Set the path to the Terraform code that will be tested.
		TerraformDir: "../examples/confluent_platform_singlenode",

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
	actualConnect := terraform.Output(t, terraformOptions, "connect")
	actualKsqlDB := terraform.Output(t, terraformOptions, "ksqldb")
	actualControlCenter := terraform.Output(t, terraformOptions, "controlcenter")
	actualSchemaRegistry := terraform.Output(t, terraformOptions, "schemaregistry")
	actualKafkaRestProxy := terraform.Output(t, terraformOptions, "kafkarestproxy")

	expectedZookeeper := "map[apiVersion:platform.confluent.io/v1beta1 kind:Zookeeper metadata:map[name:zookeeper namespace:confluent] spec:map[dataVolumeCapacity:10Gi image:map[application:confluentinc/cp-zookeeper:7.2.0 init:confluentinc/confluent-init-container:2.4.0] logVolumeCapacity:10Gi podTemplate:map[podSecurityContext:map[fsGroup:1000 runAsNonRoot:true runAsUser:1000] resources:map[requests:map[cpu:100m memory:256Mi]]] replicas:1]]"
	expectedKafka := "map[apiVersion:platform.confluent.io/v1beta1 kind:Kafka metadata:map[name:kafka namespace:confluent] spec:map[configOverrides:map[server:[confluent.license.topic.replication.factor=1 confluent.metrics.reporter.topic.replicas=1 confluent.tier.metadata.replication.factor=1 confluent.metadata.topic.replication.factor=1 confluent.balancer.topic.replication.factor=1 confluent.security.event.logger.exporter.kafka.topic.replicas=1 event.logger.exporter.kafka.topic.replicas=1 offsets.topic.replication.factor=1 confluent.cluster.link.enable=true password.encoder.secret=secret]] dataVolumeCapacity:10Gi image:map[application:confluentinc/cp-server:7.2.0 init:confluentinc/confluent-init-container:2.4.0] metricReporter:map[enabled:true] podTemplate:map[podSecurityContext:map[fsGroup:1000 runAsNonRoot:true runAsUser:1000] resources:map[requests:map[cpu:200m memory:512Mi]]] replicas:1]]"
	expectedConnect := "map[apiVersion:platform.confluent.io/v1beta1 kind:Connect metadata:map[name:connect namespace:confluent] spec:map[configOverrides:map[server:[config.storage.replication.factor=1 offset.storage.replication.factor=1 status.storage.replication.factor=1]] dependencies:map[kafka:map[bootstrapEndpoint:kafka:9071]] image:map[application:confluentinc/cp-server-connect:7.2.0 init:confluentinc/confluent-init-container:2.4.0] podTemplate:map[podSecurityContext:map[fsGroup:1000 runAsNonRoot:true runAsUser:1000] probe:map[liveness:map[failureThreshold:5 periodSeconds:10 timeoutSeconds:500]] resources:map[requests:map[cpu:100m memory:256Mi]]] replicas:1]]"
	expectedKsqlDB := "map[apiVersion:platform.confluent.io/v1beta1 kind:KsqlDB metadata:map[name:ksqldb namespace:confluent] spec:map[dataVolumeCapacity:10Gi dependencies:map[schemaRegistry:map[url:http://schemaregistry.confluent.svc.cluster.local:8081]] image:map[application:confluentinc/cp-ksqldb-server:7.2.0 init:confluentinc/confluent-init-container:2.4.0] internalTopicReplicationFactor:1 podTemplate:map[podSecurityContext:map[fsGroup:1000 runAsNonRoot:true runAsUser:1000] probe:map[liveness:map[failureThreshold:5 periodSeconds:10 timeoutSeconds:500]] resources:map[requests:map[cpu:100m memory:256Mi]]] replicas:1]]"
	expectedControlCenter := "map[apiVersion:platform.confluent.io/v1beta1 kind:ControlCenter metadata:map[name:controlcenter namespace:confluent] spec:map[configOverrides:map[server:[confluent.controlcenter.command.topic.replication=1 confluent.controlcenter.replication.factor=1 confluent.metrics.reporter.topic.replicas=1 confluent.metrics.topic.replication=1 confluent.monitoring.interceptor.topic.replication=1 confluent.controlcenter.internal.topics.replication=1]] dataVolumeCapacity:10Gi dependencies:map[connect:[map[name:connect-dev url:http://connect.confluent.svc.cluster.local:8083]] ksqldb:[map[name:ksql-dev url:http://ksqldb.confluent.svc.cluster.local:8088]] schemaRegistry:map[url:http://schemaregistry.confluent.svc.cluster.local:8081]] externalAccess:map[loadBalancer:map[domain:minikube.domain] type:loadBalancer] image:map[application:confluentinc/cp-enterprise-control-center:7.2.0 init:confluentinc/confluent-init-container:2.4.0] podTemplate:map[podSecurityContext:map[fsGroup:1000 runAsNonRoot:true runAsUser:1000] probe:map[liveness:map[failureThreshold:5 periodSeconds:10 timeoutSeconds:500]] resources:map[requests:map[cpu:500m memory:512Mi]]] replicas:1]]"
	expectedSchemaRegistry := "map[apiVersion:platform.confluent.io/v1beta1 kind:SchemaRegistry metadata:map[name:schemaregistry namespace:confluent] spec:map[image:map[application:confluentinc/cp-schema-registry:7.2.0 init:confluentinc/confluent-init-container:2.4.0] podTemplate:map[podSecurityContext:map[fsGroup:1000 runAsNonRoot:true runAsUser:1000] resources:map[requests:map[cpu:100m memory:256Mi]]] replicas:1]]"
	expectedKafkaRestProxy := "map[apiVersion:platform.confluent.io/v1beta1 kind:KafkaRestProxy metadata:map[name:kafkarestproxy namespace:confluent] spec:map[dependencies:map[schemaRegistry:map[url:http://schemaregistry.confluent.svc.cluster.local:8081]] image:map[application:confluentinc/cp-kafka-rest:7.2.0 init:confluentinc/confluent-init-container:2.4.0] podTemplate:map[podSecurityContext:map[fsGroup:1000 runAsNonRoot:true runAsUser:1000] resources:map[requests:map[cpu:100m memory:256Mi]]] replicas:1]]"

	assert.Equal(t, expectedZookeeper, actualZookeeper, "Map %q should match %q", expectedZookeeper, actualZookeeper)
	assert.Equal(t, expectedKafka, actualKafka, "Map %q should match %q", expectedKafka, actualKafka)
	assert.Equal(t, expectedConnect, actualConnect, "Map %q should match %q", expectedConnect, actualConnect)
	assert.Equal(t, expectedKsqlDB, actualKsqlDB, "Map %q should match %q", expectedKsqlDB, actualKsqlDB)
	assert.Equal(t, expectedControlCenter, actualControlCenter, "Map %q should match %q", expectedControlCenter, actualControlCenter)
	assert.Equal(t, expectedSchemaRegistry, actualSchemaRegistry, "Map %q should match %q", expectedSchemaRegistry, actualSchemaRegistry)
	assert.Equal(t, expectedKafkaRestProxy, actualKafkaRestProxy, "Map %q should match %q", expectedKafkaRestProxy, actualKafkaRestProxy)
}
