helm repo add gitlab https://charts.gitlab.io/
helm repo update
# helm upgrade --install gitlab gitlab/gitlab \
#   --timeout 600s \
#   --set global.hosts.domain=example.com \
#   --set global.hosts.externalIP=172.19.255.220 \
#   --set certmanager-issuer.email=me@example.com \ not using external certs through acme and lets encrypt
#   --set postgresql.image.tag=13.6.0

helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  --set global.hosts.externalIP=172.24.255.220 \
  --set certmanager.install=false \
  --set global.ingress.configureCertmanager=false \
  --set gitlab-runner.install=false\
  --set postgresql.image.tag=13.6.0
