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
      - config.storage.replication.factor=1
      - offset.storage.replication.factor=1
      - status.storage.replication.factor=1
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
      - confluent.controlcenter.command.topic.replication=1
      - confluent.controlcenter.replication.factor=1
      - confluent.metrics.reporter.topic.replicas=1
      - confluent.metrics.topic.replication=1
      - confluent.monitoring.interceptor.topic.replication=1
      - confluent.controlcenter.internal.topics.replication=1
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
