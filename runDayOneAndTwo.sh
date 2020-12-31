#!/bin/sh
set -o errexit

./dayOneAndTwo/0-kind-with-contour.sh
./dayOneAndTwo/1-docker-registry.sh
./dayOneAndTwo/2-dynamic-provisioning.sh
./dayOneAndTwo/3-backup-with-velero-minio.sh
