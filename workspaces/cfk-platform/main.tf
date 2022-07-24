resource "kubernetes_manifest" "zookeeper" {
  manifest   = yamldecode(file("${path.module}/manifests/zookeeper.yaml"))

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "30s"
  }
}

resource "kubernetes_manifest" "kafka" {
  manifest   = yamldecode(file("${path.module}/manifests/kafka.yaml"))

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "30s"
  }
}

resource "kubernetes_manifest" "connect" {
  manifest   = yamldecode(file("${path.module}/manifests/connect.yaml"))

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "30s"
  }
}

resource "kubernetes_manifest" "ksqldb" {
  manifest   = yamldecode(file("${path.module}/manifests/ksqldb.yaml"))

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "30s"
  }
}

resource "kubernetes_manifest" "controlcenter" {
  manifest   = yamldecode(file("${path.module}/manifests/controlcenter.yaml"))

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "30s"
  }
}

resource "kubernetes_manifest" "schemaregistry" {
  manifest   = yamldecode(file("${path.module}/manifests/schemaregistry.yaml"))

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "30s"
  }
}

resource "kubernetes_manifest" "kafkarestproxy" {
  manifest   = yamldecode(file("${path.module}/manifests/kafkarestproxy.yaml"))

  wait {
    fields = {
      "status.phase" = "RUNNING"
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "30s"
  }
}

