#!/bin/sh
set -o errexit

# create the bridge network for kind and all the registry mirrors
# connect the registry to the cluster network if not already connected
if [ "$(docker network ls |grep kind)" = '' ]; then
  docker network create kind
fi

# Now do mirror pull-through proxies
# create local registry container unless it already exists
reg_name='proxy-docker.io'
reg_port='5002'
if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
    docker run -d --name ${reg_name} --restart=always --net=kind  -p "127.0.0.1:${reg_port}:5000"  \
        -e REGISTRY_PROXY_REMOTEURL=https://registry-1.docker.io registry:2
fi

# reg_name='proxy-registry.k8s.io'
# reg_port='5003'
# if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
#     docker run -d --name ${reg_name} --restart=always --net=kind  -p "127.0.0.1:${reg_port}:5000"  \
#         -e REGISTRY_PROXY_REMOTEURL=https://registry.k8s.io registry:2
# fi

# create local registry container unless it already exists
reg_name='kind-registry'
reg_port='5001'
if [ "$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)" != 'true' ]; then
  docker run \
    -d --restart=always --net=kind -p "127.0.0.1:${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi




# create a cluster with the local registry enabled in containerd and ingress
kind create cluster --config=../contour/kind-config.yaml
kubectl apply -f ../contour/contour-config.yaml



