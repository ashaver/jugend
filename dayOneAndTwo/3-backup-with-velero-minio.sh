#!/bin/sh
set -o errexit
if [ "$(docker inspect -f '{{.State.Running}}' "minio" 2>/dev/null || true)" != 'true' ]; then
    docker run -d -p 9000:9000 -e MINIO_ACCESS_KEY=minioadmin1  -e MINIO_SECRET_KEY=minioadmin1 --name minio  -v $pwd/data:/data minio/minio server
fi



velero install \
 --provider aws \
 --plugins velero/velero-plugin-for-aws:v1.0.0 \
 --bucket velero2  \
 --secret-file ./credentials-minio  \
 --use-volume-snapshots=true \
 --backup-location-config region=default,s3ForcePathStyle="true",s3Url=http://localhost:9000  \
 --image velero/velero:v1.9.2  \
 --snapshot-location-config region="default" \
