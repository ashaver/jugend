# Jugend
So the name. It is a nod to [Kind](https://kind.sigs.k8s.io/) being the German word for child. Jugend is German for youth. 

Day one (install) is ridiculously easy with Kind K8s installs 'kind create cluster'. In contrast, day two tasks require substantial work. The documentation for Kind actively fights search engines (because kind is a keyword in kubernetes yaml configs, so nearly every distro comes up, poisoning the search). 

Jugend is an attempt to make a more mature and complete Kind installation. Overall, it should developers clear both the day one and day two hurdles quickly, so they can learn about the tech and start using it.

## Instructions
Install git submodules. Install the required libraries per the prerequisites. Then install the kind server. Then when you're done tear everything down.

As things stand, the kind server and image repo will survive restarts (though any software installed into Kind will only survive if it is designated to).

Because developers really like to have everything in a couple of scripts you could run
```bash
./installPrerequisites.sh # Only need to run once after a clone
./runDayOneAndTwo.sh # Does day 1 and 2 operations
```
And then when you're done
```bash
./tearDown.sh # Removes everything 
```

### (Only necessary once) Prerequisites
Either do a single-step install with (`./installPrerequisites.sh `) or piecemeal by initializing the submodules
```bash
git submodule init
git submodule update
```
And install the following binaries onto the path (if you need them and want these versions)
* Kind (https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
```bash 
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.9.0/kind-linux-amd64
chmod +x ./kind
sudo cp ./kind /usr/local/bin/
```
* Kubectl (https://kubernetes.io/docs/tasks/tools/install-kubectl/)
```bash 
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo cp ./kubectl /usr/local/bin/

```
* Velero (https://velero.io)
```bash 
wget https://github.com/vmware-tanzu/velero/releases/download/v1.5.2/velero-v1.5.2-linux-amd64.tar.gz
tar -xzf velero-v1.5.2-linux-amd64.tar.gz
sudo mv ./velero-v1.5.2-linux-amd64/velero /usr/local/bin/
```

### Install Kind with Day 1 and Day 2 configurations.
Run all the steps with
```bash
./runDayOneAndTwo.sh
```
or cd into the install directory and run scripts individually. Each step is sequestered into a separate script to provide flexibility (so that you could comment out steps as desired).
### Tear Down
Execute the below command to remove the kind cluster and the image repo
```bash
./tearDown.sh
```
If you just want to delete the kind cluster (so you can start over), but leave the image registry and backups in place then execute 
```bash 
kind cluster delete
```
Keeping the image registry as a persistent thing helps avoid docker  pull request throttling.

## Current Capabilities
* Dynamic Provisioning (via a fork of rancher localpath provisioner https://github.com/rancher/local-path-provisioner)
* Ingress (via a fork of contour with a simple change to create a two node cluster, as suggested by the kind K8s documentation)
* Persistent Image repository (following documentation from Kind on running with a local repo)
* Backup with Velero and Minio (with minio being external to the cluster)

## Planned Future Work
* TODO: Move Velero installation to a container-based install
* TODO: Multi-Worker Node
* TODO: ISTIO/Mesh


## Possible Future Work
* TODO: External Auth for Roles
* TODO: OpenDNS configuration and integration with Contour
* TODO: LetsEncrypt + ACME integration for services