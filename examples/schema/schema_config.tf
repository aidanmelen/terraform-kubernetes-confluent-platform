data "http" "pageviews_schema_avro" {
  url = "https://raw.githubusercontent.com/confluentinc/kafka-connect-datagen/master/src/main/resources/pageviews_schema.avro"

  request_headers = {
    Accept = "application/json"
  }
}
