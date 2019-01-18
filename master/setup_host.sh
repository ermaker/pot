set -xe

sudo cp $(dirname $0)/sysctl/* /etc/sysctl.d/
sudo service procps start
sudo sysctl --system
