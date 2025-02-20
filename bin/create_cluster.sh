#!/bin/bash

# Check if kind.yaml exists
if [ ! -f "kind.yaml" ]; then
  echo "Error: kind.yaml not found in the current directory."
  exit 1
fi

# Run kind create cluster
kind create cluster --config kind.yaml

# Check the exit status of the kind command
if [ $? -eq 0 ]; then
  echo "Kind cluster created successfully."
else
  echo "Error: Failed to create Kind cluster. Check the kind output for details."
  exit 1
fi

# Wait for the nodes to become ready
echo "Waiting for nodes to become ready..."

kubectl --context kind-kind \
    wait --for=condition=Ready --timeout=5m nodes --all

if [ $? -eq 0 ]; then
  echo "All nodes are ready."
else
  echo "Error: Timed out waiting for nodes to become ready."
  exit 1
fi

exit 0
