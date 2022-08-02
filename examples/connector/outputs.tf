output "spooldir_source_connector" {
  description = "The SpoolDir Source Connector object spec."
  value       = module.spooldir_source_connector.object["spec"]
}
