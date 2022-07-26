# terraform-kubernetes-confluent-platform/quickstart_deploy/confluent_platform_singlenode

Deploy the Confluent Platform Single Node. Similiar to the [confluent-for-kubernetes-examples/quickstart-deploy/confluent-platform-singlenode.yaml)](https://github.com/confluentinc/confluent-kubernetes-examples/blob/master/quickstart-deploy/confluent-platform-singlenode.yaml)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Example

### Confluent Platform Single Node

```hcl
module "confluent_platform_singlenode" {
  # source    = "terraform-kubernetes-confluent-platform/examples//quickstart_deploy/confluent_platform_singlenode"
  source    = "../../../"
  namespace = "confluent"

  zookeeper_spec = {
    "dataVolumeCapacity" = "10Gi"
    "image" = {
      "application" = "confluentinc/cp-zookeeper:7.2.0"
      "init"        = "confluentinc/confluent-init-container:2.4.0"
    }
    "logVolumeCapacity" = "10Gi"
    "podTemplate" = {
      "podSecurityContext" = {
        "fsGroup"      = 1000
        "runAsNonRoot" = true
        "runAsUser"    = 1000
      }
      "resources" = {
        "requests" = {
          "cpu"    = "100m"
          "memory" = "256Mi"
        }
      }
    }
    "replicas" = 1
  }

  kafka_spec = {
    "configOverrides" = {
      "server" = [
        "confluent.license.topic.replication.factor=1",
        "confluent.metrics.reporter.topic.replicas=1",
        "confluent.tier.metadata.replication.factor=1",
        "confluent.metadata.topic.replication.factor=1",
        "confluent.balancer.topic.replication.factor=1",
        "confluent.security.event.logger.exporter.kafka.topic.replicas=1",
        "event.logger.exporter.kafka.topic.replicas=1",
        "offsets.topic.replication.factor=1",
        "confluent.cluster.link.enable=true",
        "password.encoder.secret=secret",
      ]
    }
    "dataVolumeCapacity" = "10Gi"
    "image" = {
      "application" = "confluentinc/cp-server:7.2.0"
      "init"        = "confluentinc/confluent-init-container:2.4.0"
    }
    "metricReporter" = {
      "enabled" = true
    }
    "podTemplate" = {
      "podSecurityContext" = {
        "fsGroup"      = 1000
        "runAsNonRoot" = true
        "runAsUser"    = 1000
      }
      "resources" = {
        "requests" = {
          "cpu"    = "200m"
          "memory" = "512Mi"
        }
      }
    }
    "replicas" = 1
  }

  connect_spec = {
    "configOverrides" = {
      "server" = [
        "config.storage.replication.factor=1",
        "offset.storage.replication.factor=1",
        "status.storage.replication.factor=1",
      ]
    }
    "image" = {
      "application" = "confluentinc/cp-server-connect:7.2.0"
      "init"        = "confluentinc/confluent-init-container:2.4.0"
    }
    "podTemplate" = {
      "podSecurityContext" = {
        "fsGroup"      = 1000
        "runAsNonRoot" = true
        "runAsUser"    = 1000
      }
      "probe" = {
        "liveness" = {
          "failureThreshold" = 5
          "periodSeconds"    = 10
          "timeoutSeconds"   = 500
        }
      }
      "resources" = {
        "requests" = {
          "cpu"    = "100m"
          "memory" = "256Mi"
        }
      }
    }
    "replicas" = 1
  }

  ksqldb_spec = {
    "dataVolumeCapacity" = "10Gi"
    "dependencies" = {
      "schemaRegistry" = {
        "url" = "http://schemaregistry.confluent.svc.cluster.local:8081"
      }
    }
    "image" = {
      "application" = "confluentinc/cp-ksqldb-server:7.2.0"
      "init"        = "confluentinc/confluent-init-container:2.4.0"
    }
    "internalTopicReplicationFactor" = 1
    "podTemplate" = {
      "podSecurityContext" = {
        "fsGroup"      = 1000
        "runAsNonRoot" = true
        "runAsUser"    = 1000
      }
      "probe" = {
        "liveness" = {
          "failureThreshold" = 5
          "periodSeconds"    = 10
          "timeoutSeconds"   = 500
        }
      }
      "resources" = {
        "requests" = {
          "cpu"    = "100m"
          "memory" = "256Mi"
        }
      }
    }
    "replicas" = 1
  }
  control_center_spec = {
    "configOverrides" = {
      "server" = [
        "confluent.controlcenter.command.topic.replication=1",
        "confluent.controlcenter.replication.factor=1",
        "confluent.metrics.reporter.topic.replicas=1",
        "confluent.metrics.topic.replication=1",
        "confluent.monitoring.interceptor.topic.replication=1",
        "confluent.controlcenter.internal.topics.replication=1",
      ]
    }
    "dataVolumeCapacity" = "10Gi"
    "dependencies" = {
      "connect" = [
        {
          "name" = "connect-dev"
          "url"  = "http://connect.confluent.svc.cluster.local:8083"
        },
      ]
      "ksqldb" = [
        {
          "name" = "ksql-dev"
          "url"  = "http://ksqldb.confluent.svc.cluster.local:8088"
        },
      ]
      "schemaRegistry" = {
        "url" = "http://schemaregistry.confluent.svc.cluster.local:8081"
      }
    }
    "externalAccess" = {
      "loadBalancer" = {
        "domain" = "minikube.domain"
      }
      "type" = "loadBalancer"
    }
    "image" = {
      "application" = "confluentinc/cp-enterprise-control-center:7.2.0"
      "init"        = "confluentinc/confluent-init-container:2.4.0"
    }
    "podTemplate" = {
      "podSecurityContext" = {
        "fsGroup"      = 1000
        "runAsNonRoot" = true
        "runAsUser"    = 1000
      }
      "probe" = {
        "liveness" = {
          "failureThreshold" = 5
          "periodSeconds"    = 10
          "timeoutSeconds"   = 500
        }
      }
      "resources" = {
        "requests" = {
          "cpu"    = "500m"
          "memory" = "512Mi"
        }
      }
    }
    "replicas" = 1
  }

  schema_registry_spec = {
    "image" = {
      "application" = "confluentinc/cp-schema-registry:7.2.0"
      "init"        = "confluentinc/confluent-init-container:2.4.0"
    }
    "podTemplate" = {
      "podSecurityContext" = {
        "fsGroup"      = 1000
        "runAsNonRoot" = true
        "runAsUser"    = 1000
      }
      "resources" = {
        "requests" = {
          "cpu"    = "100m"
          "memory" = "256Mi"
        }
      }
    }
    "replicas" = 1
  }

  kafka_rest_proxy_spec = {
    "dependencies" = {
      "schemaRegistry" = {
        "url" = "http://schemaregistry.confluent.svc.cluster.local:8081"
      }
    }
    "image" = {
      "application" = "confluentinc/cp-kafka-rest:7.2.0"
      "init"        = "confluentinc/confluent-init-container:2.4.0"
    }
    "podTemplate" = {
      "podSecurityContext" = {
        "fsGroup"      = 1000
        "runAsNonRoot" = true
        "runAsUser"    = 1000
      }
      "resources" = {
        "requests" = {
          "cpu"    = "100m"
          "memory" = "256Mi"
        }
      }
    }
    "replicas" = 1
  }
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
| <a name="module_confluent_platform_singlenode"></a> [confluent\_platform\_singlenode](#module\_confluent\_platform\_singlenode) | ../../../ | n/a |
## Resources

No resources.
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connect"></a> [connect](#output\_connect) | The Connect CFK manifest. |
| <a name="output_control_center"></a> [control\_center](#output\_control\_center) | The ControlCenter CFK manifest. |
| <a name="output_kafka"></a> [kafka](#output\_kafka) | The Kafka CFK manifest. |
| <a name="output_kafka_rest_proxy"></a> [kafka\_rest\_proxy](#output\_kafka\_rest\_proxy) | The KafkaRestProxy CFK manifest. |
| <a name="output_ksqldb"></a> [ksqldb](#output\_ksqldb) | The KsqlDB CFK manifest. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace for the confluent platform. |
| <a name="output_schema_registry"></a> [schema\_registry](#output\_schema\_registry) | The SchemaRegistry CFK manifest. |
| <a name="output_zookeeper"></a> [zookeeper](#output\_zookeeper) | The Zookeeper CFK manifest. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
