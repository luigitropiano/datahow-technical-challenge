#!/bin/bash

# Install the microservice Helm chart
helm upgrade --install microservice-release kubernetes/microservice \
    --namespace ingress-nginx --create-namespace

# Check the exit status of the helm command
if [ $? -eq 0 ]; then
  echo "Microservice Helm chart installation started successfully."
else
  echo "Error: Failed to start microservice Helm chart installation. Check the helm output for details."
  exit 1
fi

# Wait for the microservice deployment to become available

echo "Waiting for microservice deployment to become available..."

kubectl -n ingress-nginx \
    wait --for=condition=Available --timeout=5m deployment/microservice-release-microservice-one

kubectl -n ingress-nginx \
    wait --for=condition=Available --timeout=5m deployment/microservice-release-microservice-two

if [ $? -eq 0 ]; then
  echo "Microservice deployment is available."
else
  echo "Error: Timed out waiting for microservice deployment to become available."
  exit 1
fi

echo "Microservice installation and availability check complete."

exit 0
