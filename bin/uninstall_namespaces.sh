#!/bin/bash

# Name of the namespace to uninstall
NAMESPACE="ingress-nginx"  # Or any other namespace you want to delete

# Check if the namespace exists
if kubectl get namespace "$NAMESPACE" 2>/dev/null; then
  # Delete the namespace
  kubectl delete namespace "$NAMESPACE"

  # Check the exit status of the delete command
  if [ $? -eq 0 ]; then
    echo "Namespace '$NAMESPACE' deleted successfully."
  else
    echo "Error: Failed to delete namespace '$NAMESPACE'. It might be in use by other resources or not exist."
    exit 1  # Exit with error if deletion fails
  fi
else
  echo "Namespace '$NAMESPACE' does not exist, skipping deletion."
fi

echo "Namespace uninstallation script complete."
exit 0
