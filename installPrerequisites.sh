#!/bin/sh
set -o errexit

git submodule init
git submodule update

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.16.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo cp ./kubectl /usr/local/bin/

wget https://github.com/vmware-tanzu/velero/releases/download/v1.9.2/velero-v1.9.2-linux-amd64.tar.gz
tar -xzf velero-v1.9.2-linux-amd64.tar.gz
sudo cp ./velero-v1.9.2-linux-amd64/velero /usr/local/bin/

wget https://get.helm.sh/helm-v3.10.1-linux-amd64.tar.gz
tar -xzvf helm-v3.10.1-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/local/bin/