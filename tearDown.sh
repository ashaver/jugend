#!/bin/sh
set -o errexit

kubectl delete cluster
docker container rm -f kind-registry minio
