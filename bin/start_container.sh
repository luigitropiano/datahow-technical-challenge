#!/bin/bash

# Build the microservice container
docker-compose build

# Check the exit status of the docker-compose build command
if [ $? -eq 0 ]; then
  echo "Microservice image built successfully."
else
  echo "Error: Failed to build microservice image. Check the build output for details."
  exit 1
fi

# Start the microservice container
docker-compose up -d

# Check the exit status of the docker-compose up command
if [ $? -eq 0 ]; then
  echo "Microservice container started successfully."
else
  echo "Error: Failed to start microservice container. Check the logs for details."
  exit 1
fi

echo "Microservice build and start complete."
exit 0
