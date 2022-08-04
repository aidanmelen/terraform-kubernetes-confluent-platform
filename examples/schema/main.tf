module "schema" {
  source    = "../../modules/schema"
  name      = "pageviews-value"
  namespace = var.namespace
  data      = <<-EOF
    {
      "connect.name": "ksql.pageviews",
      "fields": [
        {
          "name": "viewtime",
          "type": "long"
        },
        {
          "name": "userid",
          "type": "string"
        },
        {
          "name": "pageid",
          "type": "string"
        }
      ],
      "name": "pageviews",
      "namespace": "ksql",
      "type": "record"
    }
  EOF
}
