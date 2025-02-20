#!/bin/bash

# Install/upgrade the ingress-nginx Helm chart
helm upgrade --install --namespace ingress-nginx ingress-nginx ingress-nginx \
    --repo https://kubernetes.github.io/ingress-nginx \
    --set controller.hostPort.enabled=true \
    --set controller.service.type=NodePort

# Check the exit status of the helm command
if [ $? -eq 0 ]; then
  echo "Ingress-nginx Helm chart installed/upgraded successfully."
else
  echo "Error: Failed to install/upgrade ingress-nginx Helm chart. Check the helm output for details."
  exit 1
fi

# Patch the ingress-nginx deployment
kubectl --context kind-kind -n ingress-nginx \
    patch deployment ingress-nginx-controller \
    --patch '{"spec": {"template": {"spec": {"nodeSelector": {"kubernetes.io/hostname": "kind-control-plane"}, "tolerations": [{"key": "node-role.kubernetes.io/control-plane", "operator": "Exists", "effect": "NoSchedule"}]}}}}'

# Check the exit status of the patch command
if [ $? -eq 0 ]; then
  echo "Ingress-nginx deployment patched successfully."
else
  echo "Error: Failed to patch ingress-nginx deployment. Check the kubectl output for details."
  exit 1
fi

echo "Ingress-nginx installation/upgrade and patch complete."
exit 0
