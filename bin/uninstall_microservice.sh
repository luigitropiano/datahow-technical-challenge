#!/bin/bash

# Uninstall the microservice Helm chart

helm uninstall microservice-release -n ingress-nginx

# Check the exit status of the helm command
if [ $? -eq 0 ]; then
  echo "Microservice Helm chart uninstalled successfully."
else
  echo "Error: Failed to uninstall microservice Helm chart. Check the helm output for details."
  exit 1
fi

echo "Microservice successfully uninstalled."

exit 0
