set -xe

curl --noproxy localhost -XPUT 'http://localhost:9200/_template/index_setting?pretty=true' -H 'Content-Type: application/json' -d '{
  "index_patterns": ["*"],
  "order": 0,
  "settings": {
    "number_of_shards" : "1",
    "number_of_replicas" : "0"
  }
}'

exit

curl --noproxy localhost -XPUT 'http://localhost:9200/_template/logstash?pretty=true' -H 'Content-Type: application/json' -d '{
  "index_patterns": ["logstash-*"],
  "order": 1,
  "mappings": {
    "doc": {
      "dynamic_templates": [
        {
          "default_string_to_not_analyzed": {
            "match_mapping_type": "string",
            "mapping": {
              "type": "keyword"
            }
          }
        }
      ],
      "properties": {
        "message": { "type": "text" },
        "docker.number": { "type": "integer" }
      }
    }
  }
}'
