#!/bin/sh
set -o errexit

kind delete cluster
docker container rm -f kind-registry minio
