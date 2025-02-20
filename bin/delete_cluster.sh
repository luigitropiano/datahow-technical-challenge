#!/bin/bash

# Delete the Kind cluster

kind delete cluster

# Check the exit status of the kind command
if [ $? -eq 0 ]; then
  echo "Kind cluster deleted successfully."
else
  echo "Error: Failed to delete Kind cluster. Check the kind output for details."
  exit 1
fi

echo "Kind cluster deletion complete."
exit 0
