
#!/bin/bash

# Uninstall the ingress-nginx Helm chart
helm uninstall ingress-nginx -n ingress-nginx

# Check the exit status of the helm command
if [ $? -eq 0 ]; then
  echo "Ingress-nginx Helm chart uninstalled successfully."
else
  echo "Error: Failed to uninstall ingress-nginx Helm chart. Check the helm output for details."
  exit 1
fi

echo "Ingress-nginx succesfully uninstalled."
exit 0
