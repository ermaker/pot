set -xe

export $(grep -v '^#' .env | xargs)

curl --noproxy localhost -XDELETE 'http://localhost:9200/*?pretty=true'
