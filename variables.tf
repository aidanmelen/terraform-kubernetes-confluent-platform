variable "namespace" {
  type        = string
  description = "The namespace to install the release into."
  default     = "confluent"
}

variable "zookeeper_spec" {
  type        = any
  description = "The Zookeeper spec."
  default = {
    "dataVolumeCapacity" = "10Gi"
    "image" = {
      "application" = "confluentinc/cp-zookeeper:7.0.1"
      "init"        = "confluentinc/confluent-init-container:2.2.0-1"
    }
    "logVolumeCapacity" = "10Gi"
    "replicas"          = 3
  }
}

variable "kafka_spec" {
  type        = any
  description = "The Kafka spec."
  default = {
    "dataVolumeCapacity" = "10Gi"
    "image" = {
      "application" = "confluentinc/cp-server:7.0.1"
      "init"        = "confluentinc/confluent-init-container:2.2.0-1"
    }
    "metricReporter" = {
      "enabled" = true
    }
    "replicas" = 3
  }
}

variable "connect_spec" {
  type        = any
  description = "The Connect spec."
  default = {
    "dependencies" = {
      "kafka" = {
        "bootstrapEndpoint" = "kafka:9071"
      }
    }
    "image" = {
      "application" = "confluentinc/cp-server-connect:7.0.1"
      "init"        = "confluentinc/confluent-init-container:2.2.0-1"
    }
    "replicas" = 1
  }
}

variable "ksqldb_spec" {
  type        = any
  description = "The KsqlDB spec."
  default = {
    "dataVolumeCapacity" = "10Gi"
    "image" = {
      "application" = "confluentinc/cp-ksqldb-server:7.0.1"
      "init"        = "confluentinc/confluent-init-container:2.2.0-1"
    }
    "replicas" = 1
  }
}

variable "control_center_spec" {
  type        = any
  description = "The ControlCenter spec."
  default = {
    "dataVolumeCapacity" = "10Gi"
    "dependencies" = {
      "connect" = [
        {
          "name" = "connect"
          "url"  = "http://connect.confluent.svc.cluster.local:8083"
        },
      ]
      "ksqldb" = [
        {
          "name" = "ksqldb"
          "url"  = "http://ksqldb.confluent.svc.cluster.local:8088"
        },
      ]
      "schemaRegistry" = {
        "url" = "http://schemaregistry.confluent.svc.cluster.local:8081"
      }
    }
    "image" = {
      "application" = "confluentinc/cp-enterprise-control-center:7.0.1"
      "init"        = "confluentinc/confluent-init-container:2.2.0-1"
    }
    "replicas" = 1
  }
}

variable "schema_registry_spec" {
  type        = any
  description = "The SchemaRegistry spec."
  default = {
    "image" = {
      "application" = "confluentinc/cp-schema-registry:7.0.1"
      "init"        = "confluentinc/confluent-init-container:2.2.0-1"
    }
    "replicas" = 3
  }
}

variable "kafka_rest_proxy_spec" {
  type        = any
  description = "The KafkaRestProxy spec."
  default = {
    "dependencies" = {
      "schemaRegistry" = {
        "url" = "http://schemaregistry.confluent.svc.cluster.local:8081"
      }
    }
    "image" = {
      "application" = "confluentinc/cp-kafka-rest:7.0.1"
      "init"        = "confluentinc/confluent-init-container:2.2.0-1"
    }
    "replicas" = 1
  }
}
