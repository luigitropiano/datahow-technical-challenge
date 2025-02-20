#!/bin/bash

# Stop the microservice container
docker-compose down

# Check the exit status of the docker-compose down command
if [ $? -eq 0 ]; then
  echo "Microservice container stopped successfully."
else
  echo "Error: Failed to stop microservice container. Check the logs for details."
  exit 1
fi

echo "Microservice stop complete."
exit 0
