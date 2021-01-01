#!/bin/sh
set -o errexit

cd dayOneAndTwo
./0-kind-with-contour.sh
./1-docker-registry.sh
./2-dynamic-provisioning.sh
./3-backup-with-velero-minio.sh
