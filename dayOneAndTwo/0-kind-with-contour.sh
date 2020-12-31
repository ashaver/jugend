#!/bin/sh
set -o errexit

# create a cluster with the local registry enabled in containerd and ingress
kind create cluster --config ../contour/examples/kind/kind-expose-port.yaml
kubectl apply -f ../contour/examples/contour
