#!/bin/sh
set -o errexit

git submodule init
git submodule update

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.9.0/kind-linux-amd64
chmod +x ./kind
sudo cp ./kind /usr/local/bin/

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo cp ./kubectl /usr/local/bin/

wget https://github.com/vmware-tanzu/velero/releases/download/v1.5.2/velero-v1.5.2-linux-amd64.tar.gz
tar -xzf velero-v1.5.2-linux-amd64.tar.gz
sudo mv ./velero-v1.5.2-linux-amd64/velero /usr/local/bin/
