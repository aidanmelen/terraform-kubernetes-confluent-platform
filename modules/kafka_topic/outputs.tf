output "object" {
  description = "The Kafka Topic object."
  value       = data.kubernetes_resource.topic.object
}
