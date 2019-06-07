set -xe

export $(grep -v '^#' .env | xargs)

curl --noproxy localhost -XPUT "http://${ES_USERNAME}:${ES_PASSWORD}@localhost:9200/_template/index_setting?pretty=true" -H 'Content-Type: application/json' -d '{
  "index_patterns": ["*"],
  "order": 0,
  "settings": {
    "number_of_replicas" : 0
  }
}'

curl --noproxy localhost -XPUT "http://${ES_USERNAME}:${ES_PASSWORD}@localhost:9200/*/_settings?pretty=true" -H 'Content-Type: application/json' -d '{
  "index": {
    "number_of_replicas" : 0
  }
}'

curl --noproxy localhost -XPUT "http://${ES_USERNAME}:${ES_PASSWORD}@localhost:9200/_template/fluentd?pretty=true" -H 'Content-Type: application/json' -d '{
  "index_patterns": ["fluentd-*"],
  "order": 1,
  "settings": {
    "codec": "best_compression"
  },
  "mappings": {
    "properties": {
      "message": { "type": "text" },
      "docker.number": { "type": "integer" }
    }
  }
}'

curl --noproxy localhost -XPUT "http://${ES_USERNAME}:${ES_PASSWORD}@localhost:9200/_template/metricbeat?pretty=true" -H 'Content-Type: application/json' -d '{
  "index_patterns": ["metricbeat-*"],
  "order": 1,
  "settings": {
    "codec": "best_compression"
  }
}'
