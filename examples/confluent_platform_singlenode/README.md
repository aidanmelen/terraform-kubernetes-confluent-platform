# confluent_platform_singlenode

Deploy the Confluent Platform Single Node. Similiar to the [confluent-for-kubernetes-examples/quickstart-deploy/confluent-platform-singlenode.yaml)](https://github.com/confluentinc/confluent-kubernetes-examples/blob/master/quickstart-deploy/confluent-platform-singlenode.yaml)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

### Confluent Platform Single Node

```hcl
# https://github.com/aidanmelen/terraform-kubernetes-confluent-platform/tree/main/examples/confluent_platform
module "confluent_platform_singlenode" {
  source    = "../../"
  namespace = "confluent"

  zookeeper = yamldecode(<<EOF
spec:
  replicas: 1
  podTemplate:
    resources:
      requests:
        cpu: 100m
        memory: 256Mi
    podSecurityContext:
      fsGroup: 1000
      runAsUser: 1000
      runAsNonRoot: true
  EOF
  )

  kafka = yamldecode(<<EOF
spec:
  replicas: 1
  configOverrides:
    server:
      - "confluent.license.topic.replication.factor=1"
      - "confluent.metrics.reporter.topic.replicas=1"
      - "confluent.tier.metadata.replication.factor=1"
      - "confluent.metadata.topic.replication.factor=1"
      - "confluent.balancer.topic.replication.factor=1"
      - "confluent.security.event.logger.exporter.kafka.topic.replicas=1"
      - "event.logger.exporter.kafka.topic.replicas=1"
      - "offsets.topic.replication.factor=1"
      - "confluent.cluster.link.enable=true"
      - "password.encoder.secret=secret"
  podTemplate:
    resources:
      requests:
        cpu: 200m
        memory: 512Mi
    podSecurityContext:
      fsGroup: 1000
      runAsUser: 1000
      runAsNonRoot: true
  metricReporter:
    enabled: true
  EOF
  )

  connect = yamldecode(<<EOF
spec:
  replicas: 1
  configOverrides:
    server:
      - "config.storage.replication.factor=1"
      - "offset.storage.replication.factor=1"
      - "status.storage.replication.factor=1"
  podTemplate:
    resources:
      requests:
        cpu: 100m
        memory: 256Mi
    probe:
      liveness:
        periodSeconds: 10
        failureThreshold: 5
        timeoutSeconds: 500
    podSecurityContext:
      fsGroup: 1000
      runAsUser: 1000
      runAsNonRoot: true
  EOF
  )

  ksqldb = yamldecode(<<EOF
spec:
  replicas: 1
  internalTopicReplicationFactor: 1
  dependencies:
    schemaRegistry:
      url: http://schemaregistry.confluent.svc.cluster.local:8081
  podTemplate:
    resources:
      requests:
        cpu: 100m
        memory: 256Mi
    probe:
      liveness:
        periodSeconds: 10
        failureThreshold: 5
        timeoutSeconds: 500
    podSecurityContext:
      fsGroup: 1000
      runAsUser: 1000
      runAsNonRoot: true
  EOF
  )

  controlcenter = yamldecode(<<EOF
spec:
  replicas: 1
  configOverrides:
    server:
      - "confluent.controlcenter.command.topic.replication=1"
      - "confluent.controlcenter.replication.factor=1"
      - "confluent.metrics.reporter.topic.replicas=1"
      - "confluent.metrics.topic.replication=1"
      - "confluent.monitoring.interceptor.topic.replication=1"
      - "confluent.controlcenter.internal.topics.replication=1"
  externalAccess:
    type: loadBalancer
    loadBalancer:
      domain: minikube.domain
  podTemplate:
    resources:
      requests:
        cpu: 500m
        memory: 512Mi
    probe:
      liveness:
        periodSeconds: 10
        failureThreshold: 5
        timeoutSeconds: 500
    podSecurityContext:
      fsGroup: 1000
      runAsUser: 1000
      runAsNonRoot: true
  dependencies:
    schemaRegistry:
      url: http://schemaregistry.confluent.svc.cluster.local:8081
    ksqldb:
    - name: ksql-dev
      url: http://ksqldb.confluent.svc.cluster.local:8088
    connect:
    - name: connect-dev
      url:  http://connect.confluent.svc.cluster.local:8083
  EOF
  )

  schemaregistry = yamldecode(<<EOF
spec:
  replicas: 1
  podTemplate:
    resources:
      requests:
        cpu: 100m
        memory: 256Mi
    podSecurityContext:
      fsGroup: 1000
      runAsUser: 1000
      runAsNonRoot: true
  EOF
  )

  kafkarestproxy = yamldecode(<<EOF
spec:
  replicas: 1
  dependencies:
    schemaRegistry:
      url: http://schemaregistry.confluent.svc.cluster.local:8081
  podTemplate:
    resources:
      requests:
        cpu: 100m
        memory: 256Mi
    podSecurityContext:
      fsGroup: 1000
      runAsUser: 1000
      runAsNonRoot: true
  EOF
  )
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.8 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.12.1 |
## Providers

No providers.
## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_confluent_platform_singlenode"></a> [confluent\_platform\_singlenode](#module\_confluent\_platform\_singlenode) | ../../ | n/a |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connect"></a> [connect](#output\_connect) | The Connect CFK manifest. |
| <a name="output_controlcenter"></a> [controlcenter](#output\_controlcenter) | The ControlCenter CFK manifest. |
| <a name="output_kafka"></a> [kafka](#output\_kafka) | The Kafka CFK manifest. |
| <a name="output_kafkarestproxy"></a> [kafkarestproxy](#output\_kafkarestproxy) | The KafkaRestProxy CFK manifest. |
| <a name="output_ksqldb"></a> [ksqldb](#output\_ksqldb) | The KsqlDB CFK manifest. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the Confluent Platform. |
| <a name="output_schemaregistry"></a> [schemaregistry](#output\_schemaregistry) | The SchemaRegistry CFK manifest. |
| <a name="output_zookeeper"></a> [zookeeper](#output\_zookeeper) | The Zookeeper CFK manifest. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
