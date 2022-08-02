module "confluent_platform" {
  source = "../confluent_platform_singlenode"
}

module "file_stream_source_connector" {
  source = "../../modules/connector"

  name      = "my-file-stream-source-connector"
  namespace = "confluent"
  class     = "FileStreamSource"

  config = {
    "tasks.max" : "1"
    "file" : "/tmp/test.txt"
    "topic" : "connect-test"
  }
}

# module "file_stream_sink_connector" {
#   source = "../../modules/connector"

#   name      = "my-file-stream-sink-connector"
#   namespace = "confluent"

#   values = yamldecode(<<EOF
# spec:
#   class: "FileStreamSink"
#   taskMax: 3
#   connectClusterRef:
#     name: connect
#   configs:
#     tasks.max: "1"
#     file: "/tmp/test.txt"
#     topic: "connect-test"
#   EOF
#   )
# }
