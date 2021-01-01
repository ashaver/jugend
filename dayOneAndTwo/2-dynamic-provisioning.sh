#!/bin/sh
set -o errexit

# Dynamic provisioning local storage (via rancher local-path provisioner https://github.com/rancher/local-path-provisioner )
kubectl apply -f ../local-path-provisioner/deploy/local-path-storage.yaml 
