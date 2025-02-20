#!/bin/bash

NAMESPACE="microservice"  # Define the namespace name as a variable

kubectl --context kind-kind create namespace "$NAMESPACE" || true
echo "Namespace '$NAMESPACE' created or already exists."

# Wait for the 'microservice' namespace to become available
echo "Waiting for 'microservice' namespace to become available..."

kubectl --context kind-kind \
    wait --for jsonpath='{.status.phase}=Active' --timeout=1m namespace/"$NAMESPACE"

if [ $? -eq 0 ]; then
  echo "$NAMESPACE namespace is available."
else
  echo "Error: Timed out waiting for $NAMESPACE namespace to become available."
  exit 1
fi


