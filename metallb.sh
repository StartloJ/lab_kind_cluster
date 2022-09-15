#! /bin/bash
set -euxo pipefail

VERSION=v0.12.1

# Apply Metal LB new namespace
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$VERSION/manifests/namespace.yaml

# Apply CRDs for Metal LB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$VERSION/manifests/metallb.yaml

# Wait for the Metallb to be healthy
max_retries=200
c=0
echo "waiting for the controller to be ready"
while [[ $(kubectl -n metallb-system get deployments controller -o jsonpath="{.status.readyReplicas}") != 1 ]]
do
  ((c++)) && ((c==max_retries)) && exit -1
  sleep 1
done

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 172.18.255.200-172.18.255.250
EOF

# Restart pods
# kubectl -n metallb-system rollout restart deployment controller