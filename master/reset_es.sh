set -xe

curl --noproxy localhost -XDELETE 'http://localhost:9200/*?pretty=true'
