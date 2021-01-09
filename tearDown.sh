#!/bin/sh
set -o errexit

kind delete cluster
docker container rm -f  minio
docker container rm -f kind-registry
