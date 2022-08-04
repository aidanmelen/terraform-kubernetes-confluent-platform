module "schema" {
  source = "../../modules/schema"

  name      = "pageviews"
  namespace = var.namespace
  schema    = data.http.pageviews_schema_avro.body
}
