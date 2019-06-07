set -xe

curl --noproxy localhost -XPUT 'http://localhost:9200/_template/index_setting?pretty=true' -H 'Content-Type: application/json' -d '{
  "index_patterns": ["*"],
  "order": 0,
  "settings": {
    "number_of_replicas" : "0"
  }
}'

exit

curl --noproxy localhost -XPUT 'http://localhost:9200/_template/fluentd?pretty=true' -H 'Content-Type: application/json' -d '{
  "index_patterns": ["fluentd-*"],
  "order": 1,
  "settings": {
    "codec": "best_compression"
  },
  "mappings": {
    "_doc": {
      "dynamic_templates": [
        {
          "strings": {
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
