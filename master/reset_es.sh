set -xe

export $(grep -v '^#' .env | xargs)

curl --noproxy localhost -XDELETE "http://${ES_USERNAME}:${ES_PASSWORD}@localhost:9200/*?pretty=true"
